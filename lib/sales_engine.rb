require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(load_paths)
    @merchants     = MerchantRepository.new(load_paths[:merchants], self)
    @items         = ItemRepository.new(load_paths[:items], self)
    @invoices      = InvoiceRepository.new(load_paths[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(load_paths[:invoice_items], self)
    @transactions  = TransactionRepository.new(load_paths[:transactions], self)
    @customers     = CustomerRepository.new(load_paths[:customers], self)
  end

  def self.from_csv(load_paths)
    self.new(load_paths)
  end

  def find_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_item_id(item_id)
    merchants.find_by_id(item_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_invoice_id(invoice_id)
    merchants.find_by_id(invoice_id)
  end

  def find_items_by_invoice_id(invoice_id)
    item_ids = invoice_items.find_all_item_ids_by_invoice_id(invoice_id)
    item_ids.map do |item_id|
      items.find_by_id(item_id)
    end
  end

  def find_transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_customer_by_invoice_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def find_invoice_by_transaction_id(invoice_id)
    invoices.find_by_id(invoice_id)
  end

  def find_customers_by_merchant_id(merchant_id)
    customer_ids = invoices.find_all_customer_ids_by_merchant_id(merchant_id)
    customer_ids.uniq.map do |customer_id|
      customers.find_by_id(customer_id)
    end
  end

  def find_merchants_by_customer_id(customer_id)
    merchant_ids = invoices.find_all_merchant_ids_by_customer_id(customer_id)
    merchant_ids.uniq.map do |merchant_id|
      merchants.find_by_id(merchant_id)
    end
  end
end

# temp_item.rb
#require 'minitest/mock'
#mock_se = Minitest::Mock.new
#mock_se.expect(:find_merchant_by_id, "merchant", ["merchant_id"])
