class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine      = sales_engine
    @all_merchants     = @sales_engine.merchants.merchants
    @all_items         = @sales_engine.items.items
    @all_invoices      = @sales_engine.invoices.invoices
    @all_invoice_items = @sales_engine.invoice_items.invoice_items
    @all_transactions  = @sales_engine.transactions.transactions
    @all_customers     = @sales_engine.customers.customers
  end

  def average_items_per_merchant
    (@all_items.count.to_f / @all_merchants.count).round(2)
  end

  def items_per_merchant
    @all_merchants.keys.map do |merchant_id|
      sales_engine.items.find_all_by_merchant_id(merchant_id).count
    end
  end

  def sample_standard_deviation(sample, average)
    differences_squared = sample.map do |number|
      (number - average) ** 2
    end
    Math.sqrt( differences_squared.reduce(:+) /
    (sample.count - 1).to_f ).round(2)
  end

  def average_items_per_merchant_standard_deviation
    sample_standard_deviation(items_per_merchant, average_items_per_merchant)
  end

  def coefficient_of_variation(average, standard_deviation, coefficient)
    average + coefficient * standard_deviation
  end

  def merchants_with_high_item_count
    cov = coefficient_of_variation(average_items_per_merchant,
    average_items_per_merchant_standard_deviation, 1)
    @all_merchants.values.find_all do |merchant|
      sales_engine.items.find_all_by_merchant_id(merchant.id).count > cov
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    items.inject(0) do |sum, item|
      sum += item.unit_price / items.count.to_f
    end.round(2)
  end

  def average_average_price_per_merchant
    total_merchants = @all_merchants.count
    @all_merchants.keys.inject(0) do |sum, merchant_id|
      sum += average_item_price_for_merchant(merchant_id) / total_merchants.to_f
    end.round(2)
  end

  def average_item_price
    total_items = @all_items.count
    @all_items.values.inject(0) do |sum, item|
      sum += item.unit_price / total_items.to_f
    end.round(2)
  end

  def item_price_standard_deviation
    item_prices = @all_items.values.map do |item|
      item.unit_price
    end
    sample_standard_deviation(item_prices, average_item_price)
  end

  def golden_items
    cov = coefficient_of_variation(average_item_price,
    item_price_standard_deviation, 2)
    @all_items.values.find_all do |item|
      item.unit_price > cov
    end
  end

  def average_invoices_per_merchant
    (@all_invoices.count.to_f / @all_merchants.count).round(2)
  end

  def invoices_per_merchant
    @all_merchants.keys.map do |merchant_id|
      sales_engine.invoices.find_all_by_merchant_id(merchant_id).count
    end
  end

  def average_invoices_per_merchant_standard_deviation
    sample_standard_deviation(invoices_per_merchant, average_invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    cov = coefficient_of_variation(average_invoices_per_merchant,
    average_invoices_per_merchant_standard_deviation, 2)
    @all_merchants.values.find_all do |merchant|
      sales_engine.invoices.find_all_by_merchant_id(merchant.id).count > cov
    end
  end

  def bottom_merchants_by_invoice_count
    cov = coefficient_of_variation(average_invoices_per_merchant,
    average_invoices_per_merchant_standard_deviation, -2)
    @all_merchants.values.find_all do |merchant|
      sales_engine.invoices.find_all_by_merchant_id(merchant.id).count < cov
    end
  end

  def invoices_per_day
    @all_invoices.values.each_with_object(Hash.new(0)) do |invoice, per_day|
      per_day[invoice.created_at.strftime('%A')] += 1
    end
  end

  def average_invoices_per_day
    (@all_invoices.count.to_f / 7 ).round(2)
  end

  def invoices_per_day_standard_deviation
    sample_standard_deviation(invoices_per_day.values, average_invoices_per_day)
  end

  def top_days_by_invoice_count
    cov = coefficient_of_variation(average_invoices_per_day,
    invoices_per_day_standard_deviation, 1)
    invoices_per_day.select do |day, quantity|
      quantity > cov
    end.keys
  end

  def invoices_by_status
    @all_invoices.values.each_with_object(Hash.new(0)) do |invoice, statuses|
      statuses[invoice.status] += 1
    end
  end

  def invoice_status(status)
    ( 100 * invoices_by_status[status] / @all_invoices.count.to_f ).round(2)
  end

  def matches_date_and_paid_in_full?(date, invoice)
    invoice.created_at.strftime("%F") == date.strftime("%F") &&
    @sales_engine.transactions.is_paid_in_full?(invoice.id)
  end

  def find_invoice_ids_by_date(date)
    @all_invoices.values.each_with_object([]) do |invoice, invoice_ids|
      if matches_date_and_paid_in_full?(date, invoice)
        invoice_ids << invoice.id
      end
    end
  end

  def total_revenue_by_date(date)
    invoice_ids = find_invoice_ids_by_date(date)
    @all_invoice_items.values.inject(0) do |sum, invoice_item|
      if invoice_ids.include?(invoice_item.invoice_id)
        sum += invoice_item.unit_price * invoice_item.quantity
      end
      sum
    end.round(2)
  end

  def revenue_by_merchant(merchant_id)
    invoices = sales_engine.invoices.find_all_by_merchant_id(merchant_id)
    invoices.inject(0) do |sum, invoice|
      sum += revenue_by_invoice_id(invoice.id)
    end
  end

  def revenue_by_invoice_id(invoice_id)
    if @sales_engine.transactions.is_paid_in_full?(invoice_id)
      @all_invoice_items.values.inject(0) do |sum, invoice_item|
        sum += invoice_item.unit_price * invoice_item.quantity
      end
    else
      0
    end.round(2)
  end

  def top_revenue_earners(x = 20)
    f = @all_merchants.values.sort_by do |merchant|
      revenue_by_merchant(merchant.id)
    end.reverse.take(x)
    require "pry"; binding.pry
  end

  def find_pending_invoices
    @all_invoices.values.delete_if do |invoice|
      sales_engine.transactions.is_paid_in_full?(invoice.id)
    end
  end

  def merchants_with_pending_invoices
    find_pending_invoices.map do |invoice|
      sales_engine.merchants.find_by_id(invoice.merchant_id)
    end.uniq
  end

  def find_items_by_merchant(merchant_id)
    @all_items.values.count do |item|
      item.merchant_id == merchant_id
    end
  end

  def merchants_with_only_one_item
    @all_merchants.values.keep_if do |merchant|
      find_items_by_merchant(merchant.id) == 1
    end
  end

  # def merchants_with_only_one_item_registered_in_month(month_name)
  #
  # end

end
