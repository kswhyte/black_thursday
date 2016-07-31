class Customer
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(customer, customer_repository_parent = nil)
    # @customer_repository_parent = customer_repository_parent
    @id                        = customer[:id].to_i
    # @customer_id               = customer[:customer_id].to_i
    # @merchant_id               = customer[:merchant_id].to_i
    # @status                    = customer[:status]
    # @created_at                = Time.parse(customer[:created_at])
    # @updated_at                = Time.parse(customer[:created_at])
  end
end
