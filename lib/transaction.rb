require 'bigdecimal'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(transaction, transaction_repository_parent = nil)
    @transaction_repository_parent = transaction_repository_parent
    @id                            = transaction[:id].to_i
    @invoice_id                    = transaction[:invoice_id].to_i
    @credit_card_number            = transaction[:credit_card_number]
    @credit_card_expiration_date   = transaction[:credit_card_expiration_date]
    @result                        = transaction[:result].to_sym
    @created_at                    = Time.parse(transaction[:created_at])
    @updated_at                    = Time.parse(transaction[:updated_at])
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
