require_relative '../lib/invoice'
require_relative '../lib/file_extractor'

class InvoiceRepository
  attr_reader :invoices

  def initialize(load_path, sales_engine_parent = nil)
    @sales_engine_parent = sales_engine_parent
    @invoices = {}
    if load_path.class == String && File.exist?(load_path)
      invoices_data = FileExtractor.extract_data(load_path)
      populate(invoices_data)
    end
  end

  def make_invoice(invoice_data)
    @invoices[invoice_data[:id].to_i] = Invoice.new(invoice_data, self)
  end

  def populate(invoices_data)
    invoices_data.each do |invoice_data|
      make_invoice(invoice_data)
    end
  end

  def all
    invoices.values
  end

  def find_by_id(invoice_id)
    invoices[invoice_id]
  end

  def find_all_by_customer_id(customer_id)
    invoices.values.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.values.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    invoices.values.find_all do |invoice|
      invoice.status == status
    end
  end

  def find_merchant_by_invoice_id(merchant_id)
    @sales_engine_parent.find_merchant_by_invoice_id(merchant_id)
  end

  def inspect
    # "#<#{self.class} #{@merchants.size} rows>"
  end

end
