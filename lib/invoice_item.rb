require 'bigdecimal'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(invoice_item, invoice_item_repository_parent = nil)
    @invoice_item_repository_parent = invoice_item_repository_parent
    @id         = invoice_item[:id].to_i
    @item_id    = invoice_item[:item_id].to_i
    @invoice_id = invoice_item[:invoice_id].to_i
    @quantity   = invoice_item[:quantity].to_i
    @unit_price = BigDecimal.new(invoice_item[:unit_price]) / 100
    @created_at = Time.parse(invoice_item[:created_at])
    @updated_at = Time.parse(invoice_item[:updated_at])
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
