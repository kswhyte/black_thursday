module SalesAnalystSupport
  def sample_standard_deviation(sample, average)
    differences_squared = sample.map do |number|
      (number - average) ** 2
    end
    Math.sqrt( differences_squared.reduce(:+) /
    (sample.count - 1).to_f ).round(2)
  end

  def items_per_merchant
    @all_merchants.keys.map do |merchant_id|
      sales_engine.items.find_all_by_merchant_id(merchant_id).count
    end
  end

  def coefficient_of_variation(average, standard_deviation, coefficient)
    average + coefficient * standard_deviation
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

  def invoices_per_merchant
    @all_merchants.keys.map do |merchant_id|
      sales_engine.invoices.find_all_by_merchant_id(merchant_id).count
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

  def invoices_by_status
    @all_invoices.values.each_with_object(Hash.new(0)) do |invoice, statuses|
      statuses[invoice.status] += 1
    end
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

  def find_pending_invoices
    @all_invoices.values.delete_if do |invoice|
      sales_engine.transactions.is_paid_in_full?(invoice.id)
    end
  end

  def merchants_registered_in_a_month(month_name)
    @all_merchants.values.keep_if do |merchant|
      merchant.created_at.strftime("%B") == month_name
    end
  end

  def find_paid_in_full_invoice_items_by_merchant_id(merchant_id)
    paid_invoices =
    sales_engine.invoices.find_paid_invoices_by_merchant_id(merchant_id)
    paid_invoices.flat_map do |invoice|
      sales_engine.invoice_items.find_all_by_invoice_id(invoice.id)
    end.uniq
  end

  def find_a_merchants_invoice_items_grouped_by_item(merchant_id)
    invoice_items = find_paid_in_full_invoice_items_by_merchant_id(merchant_id)
    invoice_items.group_by do |invoice_item|
      invoice_item.item_id
    end
  end

  def find_a_merchants_quantity_sold_by_item(merchant_id)
    items = find_a_merchants_invoice_items_grouped_by_item(merchant_id)
    item_quantities = {}
    items.each do |item, invoice_items|
      item_quantities[item] = sum_invoice_item_quantities(invoice_items)
    end
    item_quantities
  end

  def top_item_ids_for_merchant_by_quantity(merchant_id)
    item_totals = find_a_merchants_quantity_sold_by_item(merchant_id)
    max_quantity = item_totals.values.max
    top_item_ids = item_totals.find_all do |item, quantity|
      quantity == max_quantity
    end
  end

  def sum_invoice_item_quantities(invoice_items)
    invoice_items.inject(0) do |sum, invoice_item|
      sum += invoice_item.quantity
    end
  end

  def find_a_merchants_revenue_by_item(merchant_id)
    items = find_a_merchants_invoice_items_grouped_by_item(merchant_id)
    item_quantities = {}
    items.each do |item, invoice_items|
      item_quantities[item] = sum_invoice_item_prices(invoice_items)
    end
    item_quantities
  end

  def sum_invoice_item_prices(invoice_items)
    invoice_items.inject(0) do |sum, invoice_item|
      sum += invoice_item.quantity * invoice_item.unit_price
    end
  end
end
