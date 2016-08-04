class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(customer, customer_repository_parent = nil)
    @customer_repository_parent = customer_repository_parent
    @id                         = customer[:id].to_i
    @first_name                 = customer[:first_name]
    @last_name                  = customer[:last_name]
    @created_at                 = Time.parse(customer[:created_at])
    @updated_at                 = Time.parse(customer[:created_at])
  end

  def merchants
    @customer_repository_parent.find_merchants_by_customer_id(id)
  end
end
