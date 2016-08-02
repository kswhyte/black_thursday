require_relative '../lib/customer'
require_relative '../lib/file_extractor'

class CustomerRepository
  attr_reader :invoices,
              :customers

  def initialize(load_path, sales_engine_parent = nil)
    @sales_engine_parent = sales_engine_parent
    @customers = {}
    if load_path.class == String && File.exist?(load_path)
      customers_data = FileExtractor.extract_data(load_path)
      populate(customers_data)
    end
  end

  def make_customer(customer_data)
    @customers[customer_data[:id].to_i] = Customer.new(customer_data, self)
  end

  def populate(customers_data)
    customers_data.each do |customer_data|
      make_customer(customer_data)
    end
  end

  def all
    customers.values
  end

  def find_by_id(customer_id)
    customers[customer_id]
  end

  def find_all_by_first_name(first_name)
    customers.values.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    customers.values.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  def find_merchants_by_customer_id(customer_id)
    @sales_engine_parent.find_merchants_by_customer_id(customer_id)
  end

  def inspect
    # "#<#{self.class} #{@merchants.size} rows>"
  end
end
