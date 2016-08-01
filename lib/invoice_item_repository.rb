require_relative '../lib/invoice_item'
require_relative '../lib/file_extractor'

class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(load_path, sales_engine_parent = nil)
    @sales_engine_parent = sales_engine_parent
    @invoice_items = {}
    if load_path.class == String && File.exist?(load_path)
      invoice_items_data = FileExtractor.extract_data(load_path)
      populate(invoice_items_data)
    end
  end

  def make_invoice_item(invoice_item_data)
    invoice_items[invoice_item_data[:id].to_i] = InvoiceItem.new(invoice_item_data, self)
  end

  def populate(invoice_items_data)
    invoice_items_data.each do |invoice_item_data|
      make_invoice_item(invoice_item_data)
    end
  end

  def all
    invoice_items.values
  end

  def find_by_id(invoice_item_id)
    invoice_items[invoice_item_id]
  end

  def find_all_by_item_id(item_id)
    invoice_items.values.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.values.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def find_all_invoice_items_by_invoice_id(invoice_id)
    invoice_items.values.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def find_all_item_ids_by_invoice_id(invoice_id)
    find_all_invoice_items_by_invoice_id(invoice_id).map do |invoice|
      invoice.item_id
    end
  end

  def inspect
    # "#<#{self.class} #{@merchants.size} rows>"
  end
end
