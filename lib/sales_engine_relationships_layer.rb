module SalesEngineRelationshipsLayer
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
