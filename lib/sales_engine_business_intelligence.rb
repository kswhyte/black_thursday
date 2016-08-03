module SalesEngineBusinessIntelligence
  def is_invoice_paid_in_full?(invoice_id)
    transactions.is_paid_in_full?(invoice_id)
  end

  def calculate_invoice_total(invoice_id)
    invoice_items.calculate_invoice_total(invoice_id)
  end
end
