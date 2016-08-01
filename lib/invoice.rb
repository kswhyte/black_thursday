class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(invoice, invoice_repository_parent = nil)
    @invoice_repository_parent = invoice_repository_parent
    @id                        = invoice[:id].to_i
    @customer_id               = invoice[:customer_id].to_i
    @merchant_id               = invoice[:merchant_id].to_i
    @status                    = invoice[:status].to_sym
    @created_at                = Time.parse(invoice[:created_at])
    @updated_at                = Time.parse(invoice[:updated_at])
  end

  def merchant
    @invoice_repository_parent.find_merchant_by_invoice_id(merchant_id)
  end
end
