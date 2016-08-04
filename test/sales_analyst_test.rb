require './test/test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def sales_analyst_test_setup
    se = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                :merchants     => "./data/merchants.csv",
                                :invoices      => "./data/invoices.csv",
                                :invoice_items => "./data/invoice_items.csv",
                                :transactions  => "./data/transactions.csv",
                                :customers     => "./data/customers.csv"  })
    SalesAnalyst.new(se)
  end

  def test_it_creates_sales_analyst_with_a_sales_engine
    sa = sales_analyst_test_setup

    assert_instance_of SalesAnalyst, sa
  end

  def test_it_calculates_average_items_per_merchant
    sa = sales_analyst_test_setup

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_it_calculates_items_per_merchant
    se_sample = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./test/fixtures/merchants_sample.csv" })
    sa_sample = SalesAnalyst.new(se_sample)

    assert_equal [3, 1, 1, 1, 25, 3, 1, 1, 1, 7], sa_sample.items_per_merchant
  end

  def test_it_calculates_average_items_per_merchant_standard_deviation
    sa = sales_analyst_test_setup

    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_which_merchants_sell_the_most_items
    sa = sales_analyst_test_setup

    assert_equal       52,       sa.merchants_with_high_item_count.count
    assert_instance_of Merchant, sa.merchants_with_high_item_count.first
  end

  def test_it_calculates_the_average_price_of_merchants_items
    sa = sales_analyst_test_setup

    assert_equal 20, sa.average_item_price_for_merchant(12334115)
    assert_equal 35, sa.average_item_price_for_merchant(12334132)
    assert_equal 12, sa.average_item_price_for_merchant(12334141)
  end

  def test_it_calculates_the_average_of_the_average_price_of_all_merchants_items
    sa = sales_analyst_test_setup

    assert_equal 350.29, sa.average_average_price_per_merchant
  end

  def test_it_calculates_average_item_price
    sa = sales_analyst_test_setup

    assert_equal 251.06, sa.average_item_price
  end

  def test_it_calculates_item_price_standard_deviation
    sa = sales_analyst_test_setup

    assert_equal 2900.99, sa.item_price_standard_deviation
  end

  def test_it_calculates_golden_items
    sa = sales_analyst_test_setup

    assert_equal       5,    sa.golden_items.count
    assert_instance_of Item, sa.golden_items.first
  end

  def test_it_calculates_average_invoices_per_merchant
    sa = sales_analyst_test_setup

    assert_equal 10.49, sa.average_invoices_per_merchant
  end

  def test_it_calculates_invoices_per_merchant
    se_sample = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./test/fixtures/merchants_sample.csv",
      :invoices  => "./data/invoices.csv" })
    sa_sample = SalesAnalyst.new(se_sample)

    expected = [10, 7, 12, 11, 10, 10, 13, 18, 10, 14]
    assert_equal expected, sa_sample.invoices_per_merchant
  end

  def test_it_calculates_average_invoices_per_merchant_standard_deviation
    sa = sales_analyst_test_setup

    assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_calculates_top_performing_merchants_by_invoices
    sa = sales_analyst_test_setup

    assert_equal       12,       sa.top_merchants_by_invoice_count.count
    assert_instance_of Merchant, sa.top_merchants_by_invoice_count.first
  end

  def test_it_calculates_bottom_performing_merchants_by_invoices
    sa = sales_analyst_test_setup

    assert_equal       4,        sa.bottom_merchants_by_invoice_count.count
    assert_instance_of Merchant, sa.bottom_merchants_by_invoice_count.first
  end

  def test_it_calculates_invoices_per_day
    sa = sales_analyst_test_setup
    invoices = {"Saturday"=>729, "Friday"=>701, "Wednesday"=>741, "Monday"=>696,
      "Sunday"=>708, "Tuesday"=>692, "Thursday"=>718}

    assert_equal invoices, sa.invoices_per_day
  end

  def test_it_calculates_days_of_the_week_with_the_most_sales
    sa = sales_analyst_test_setup

    assert_equal 712.14, sa.average_invoices_per_day
  end

  def test_it_calculates_invoices_per_day_standard_deviation
    sa = sales_analyst_test_setup

    assert_equal 18.07, sa.invoices_per_day_standard_deviation
  end

  def test_it_calculates_top_days_by_invoice_count
    sa = sales_analyst_test_setup

    assert_equal ["Wednesday"], sa.top_days_by_invoice_count
  end

  def test_it_calculates_percentage_of_invoices_not_shipped
    sa = sales_analyst_test_setup

    assert_equal 29.55, sa.invoice_status(:pending)
    assert_equal 56.95, sa.invoice_status(:shipped)
    assert_equal 13.50, sa.invoice_status(:returned)
  end

  def test_it_calculates_total_revenue_for_a_given_day
    sa = sales_analyst_test_setup

    assert_equal 21067.77,  sa.total_revenue_by_date(Time.parse("2009-02-07"))
    assert_equal 33710.86,  sa.total_revenue_by_date(Time.parse("2000-04-09"))
  end

  def test_it_finds_the_top_performing_merchants_by_revenue_with_default_20
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./test/fixtures/50merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv" })
    sa = SalesAnalyst.new(se)

    assert_instance_of Merchant, sa.top_revenue_earners.first
    assert_equal       20,       sa.top_revenue_earners.count
  end

  def test_it_returns_a_list_of_all_merchants_ranked_by_revenue
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./test/fixtures/50merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv" })
    sa = SalesAnalyst.new(se)

    assert_instance_of Merchant, sa.merchants_ranked_by_revenue.sample
    assert_equal       50,       sa.merchants_ranked_by_revenue.count
  end

  def test_it_finds_merchants_with_pending_invoices
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./test/fixtures/invoices_sample.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv" })
    sa = SalesAnalyst.new(se)

    assert_instance_of Merchant, sa.merchants_with_pending_invoices.first
    assert_equal       19,       sa.merchants_with_pending_invoices.count
  end

  def test_it_calculates_total_revenue_for_a_merchant
    sa = sales_analyst_test_setup

    assert_equal 73777.17, sa.revenue_by_merchant(12334105)
  end

  def test_it_finds_merchants_who_offer_only_one_item
    sa = sales_analyst_test_setup

    assert_instance_of Merchant, sa.merchants_with_only_one_item.first
    assert_equal 1, sa.merchants_with_only_one_item.last.items.count
  end

  def test_it_finds_merchants_who_only_sell_one_item_by_month_they_registered
    sa = sales_analyst_test_setup

    merchants = sa.merchants_with_only_one_item_registered_in_month("August")

    assert_instance_of Merchant, merchants.first
    assert_equal       19,       merchants.count
  end

  def test_it_finds_most_sold_items_for_a_merchant_in_terms_of_quantity_sold
    sa = sales_analyst_test_setup

    expected = "Adult Princess Leia Hat"
    assert_equal expected, sa.most_sold_item_for_merchant(12334189).first.name
    assert_equal 1,        sa.most_sold_item_for_merchant(12334189).count
  end

  def test_it_finds_most_sold_item_for_a_merchant_in_terms_of_revenue
    sa = sales_analyst_test_setup

    assert_instance_of Item, sa.best_item_for_merchant(12334189)
  end
end
