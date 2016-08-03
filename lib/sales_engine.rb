require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine_relationships_layer.rb'
require_relative '../lib/sales_engine_business_intelligence.rb'

class SalesEngine
  include SalesEngineRelationshipsLayer
  include SalesEngineBusinessIntelligence

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
end
