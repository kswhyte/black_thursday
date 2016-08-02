require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_has_a_csv_method
    assert_respond_to(SalesEngine, :from_csv)
  end

  def test_it_takes_in_sample_merchant_csv
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })

    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_takes_in_sample_item_csv
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })

    assert_instance_of ItemRepository, se.items
  end

  def test_it_returns_a_merchant
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })
    mr = se.merchants
    merchant = mr.find_by_name("CJsDecor")

    assert_instance_of Merchant, merchant
    assert_equal "CJsDecor",     merchant.name
    assert_equal 12337411,       merchant.id
  end

  def test_it_returns_an_item
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })
    ir   = se.items
    item = ir.find_by_name("Glitter scrabble frames")

    assert_instance_of Item,                item
    assert_equal "Glitter scrabble frames", item.name
    assert_equal 263395617,                 item.id
  end

  def test_it_returns_an_item_based_on_merchant_id
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })

    merchant = se.merchants.find_by_id(12334115)
    name_of_item = merchant.items.map do |item|
      item.name
    end

    item_name = ["French bulldog cushion cover 45x45cm *cover only, pad NOT included*"]
    assert_instance_of Item, merchant.items.first
    assert_equal item_name,  name_of_item
  end

  def test_it_returns_items_based_on_another_merchant_id
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })

    merchant = se.merchants.find_by_id(12334132)
    names_of_items = merchant.items.map do |item|
      item.name
    end

    item_names = ["sautoir boheme chic perle de gemme  montee sur chainette argentée",
      "sautoir ethique couleur naturel printemps été",
      "sautoir boheme chic  en perle et pierre"]

    assert_instance_of Item, merchant.items.first
    assert_equal item_names, names_of_items
  end

  def test_it_returns_a_merchant_based_on_item_id
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })

    item = se.items.find_by_id(263397059)
    assert_instance_of Merchant,  item.merchant
    assert_equal "FlavienCouche", item.merchant.name

    item = se.items.find_by_id(263396279)
    assert_instance_of Merchant,      item.merchant
    assert_equal "MuttisStrickwaren", item.merchant.name

    item = se.items.find_by_id(263395617)
    assert_instance_of Merchant,     item.merchant
    assert_equal "Madewithgitterxx", item.merchant.name
  end

  def test_it_returns_invoices_based_on_merchant_id
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv",
                                :invoices  => "./data/invoices.csv" })

    merchant = se.merchants.find_by_id(12334132)
    invoice_ids = merchant.invoices.map do |invoice|
      invoice.id
    end

    ids = [391, 580, 1331, 1466, 2529, 3395, 3599, 3758, 3929, 4442]

    assert_instance_of Invoice, merchant.invoices.first
    assert_equal ids, invoice_ids
  end

  def test_it_returns_a_merchant_based_on_invoice_id
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv",
                                :invoices  => "./data/invoices.csv" })

    invoice = se.invoices.find_by_id(26)
    assert_instance_of Merchant,        invoice.merchant
    assert_equal "NaturePhotography23", invoice.merchant.name

    invoice = se.invoices.find_by_id(69)
    assert_instance_of Merchant,  invoice.merchant
    assert_equal "DashaandSasha", invoice.merchant.name

    invoice = se.invoices.find_by_id(617)
    assert_instance_of Merchant,      invoice.merchant
    assert_equal "SmellyHippieSoaps", invoice.merchant.name
  end

  def test_it_returns_items_based_on_invoice_id
    se = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                :merchants     => "./data/merchants.csv",
                                :invoices      => "./data/invoices.csv",
                                :invoice_items => "./data/invoice_items.csv",
                                :transactions  => "./data/transactions.csv",
                                :customers     => "./data/customers.csv" })

    invoice = se.invoices.find_by_id(81)
    names_of_items = invoice.items.map do |item|
      item.name
    end

    assert_instance_of Item,                    invoice.items.first
    assert_equal ["Wooden Shelf", "The Baron"], names_of_items
  end

  def test_it_returns_transactions_based_on_invoice_id
    se = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                :merchants     => "./data/merchants.csv",
                                :invoices      => "./data/invoices.csv",
                                :invoice_items => "./data/invoice_items.csv",
                                :transactions  => "./data/transactions.csv",
                                :customers     => "./data/customers.csv" })

    invoice = se.invoices.find_by_id(46)
    transaction_ids = invoice.transactions.map do |transaction|
      transaction.id
    end

    assert_instance_of Transaction, invoice.transactions.first
    assert_equal [2, 1370],         transaction_ids
  end

  def test_it_returns_items_based_on_invoice_id
    se = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                :merchants     => "./data/merchants.csv",
                                :invoices      => "./data/invoices.csv",
                                :invoice_items => "./data/invoice_items.csv",
                                :transactions  => "./data/transactions.csv",
                                :customers     => "./data/customers.csv" })

    invoice = se.invoices.find_by_id(81)
    names_of_items = invoice.items.map do |item|
      item.name
    end

    assert_instance_of Item,                    invoice.items.first
    assert_equal ["Wooden Shelf", "The Baron"], names_of_items
  end

  def test_it_returns_a_customer_based_on_invoice_id
    se = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                :merchants     => "./data/merchants.csv",
                                :invoices      => "./data/invoices.csv",
                                :invoice_items => "./data/invoice_items.csv",
                                :transactions  => "./data/transactions.csv",
                                :customers     => "./data/customers.csv" })

    invoice = se.invoices.find_by_id(81)

    assert_instance_of Customer, invoice.customer
    assert_equal "Hoppe",        invoice.customer.last_name
  end

  def test_it_returns_an_invoice_based_on_transaction_id
    se = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                :merchants     => "./data/merchants.csv",
                                :invoices      => "./data/invoices.csv",
                                :invoice_items => "./data/invoice_items.csv",
                                :transactions  => "./data/transactions.csv",
                                :customers     => "./data/customers.csv" })

    transaction = se.transactions.find_by_id(40)

    assert_instance_of Invoice, transaction.invoice
    assert_equal 12335150,      transaction.invoice.merchant_id
  end

  def test_it_returns_customers_based_on_merchant_id
    se = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                :merchants     => "./data/merchants.csv",
                                :invoices      => "./data/invoices.csv",
                                :invoice_items => "./data/invoice_items.csv",
                                :transactions  => "./data/transactions.csv",
                                :customers     => "./data/customers.csv" })

    merchant = se.merchants.find_by_id(12334194)
    last_names_of_customers = merchant.customers.map do |customer|
      customer.last_name
    end
    customer_last_names = ["Gulgowski", "Cormier", "Hackett", "Borer", "Nolan",
      "Morar", "Cormier", "Spinka", "Cremin", "Quitzon", "Brown", "Flatley"]

    assert_instance_of Customer,      merchant.customers.first
    assert_equal customer_last_names, last_names_of_customers
  end

  def test_it_returns_merchants_based_on_customer_id
    se = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                :merchants     => "./data/merchants.csv",
                                :invoices      => "./data/invoices.csv",
                                :invoice_items => "./data/invoice_items.csv",
                                :transactions  => "./data/transactions.csv",
                                :customers     => "./data/customers.csv" })

    customer = se.customers.find_by_id(30)
    names_of_merchants = customer.merchants.map do |customer|
      customer.name
    end
    merchant_names = ["SweetheartDarling", "TiffsOscPandora", "VectorCoast",
      "wholesalergemstones", "thepurplepenshop"]

    assert_instance_of Merchant,  customer.merchants.first
    assert_equal merchant_names,  names_of_merchants
  end

  def test_it_checks_if_the_invoice_is_paid_in_full
    se = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                :merchants     => "./data/merchants.csv",
                                :invoices      => "./data/invoices.csv",
                                :invoice_items => "./data/invoice_items.csv",
                                :transactions  => "./data/transactions.csv",
                                :customers     => "./data/customers.csv" })

    invoice = se.invoices.find_by_id(46)
    assert invoice.is_paid_in_full?

    invoice = se.invoices.find_by_id(200)
    assert invoice.is_paid_in_full?

    invoice = se.invoices.find_by_id(21)
    refute invoice.is_paid_in_full?

    invoice = se.invoices.find_by_id(204)
    refute invoice.is_paid_in_full?
  end

  def test_it_returns_total_amount_of_an_invoice
    se = SalesEngine.from_csv({ :items         => "./data/items.csv",
                                :merchants     => "./data/merchants.csv",
                                :invoices      => "./data/invoices.csv",
                                :invoice_items => "./data/invoice_items.csv",
                                :transactions  => "./data/transactions.csv",
                                :customers     => "./data/customers.csv" })

    invoice = se.invoices.find_by_id(81)
    assert_equal 5355.66, invoice.total

    invoice = se.invoices.find_by_id(1)
    assert_equal 21067.77, invoice.total

    invoice = se.invoices.find_by_id(75)
    assert_equal 17782.28, invoice.total
  end

# invoice.total returns the total $ amount of the invoice
# Note: Failed charges should never be counted in revenue totals or statistics.

end
