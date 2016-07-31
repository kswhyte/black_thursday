require './test/test_helper'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_it_exists
    cr = CustomerRepository.new("./data/customers.csv")

    assert_instance_of CustomerRepository, cr
  end

  # def test_it_populates_repository_with_customers
  #   cr = CustomerRepository.new("./data/customers.csv")
  #
  #   assert_equal 4985, cr.customers.count
  # end
  #
  # def test_it_returns_an_customer_from_repository
  #   cr = CustomerRepository.new("./data/customers.csv")
  #
  #   assert_instance_of Customer, cr.customers[7]
  #   assert_instance_of Customer, cr.customers[1]
  #   assert_instance_of Customer, cr.customers[11]
  # end
  #
  # def test_it_returns_a_list_of_all_customers
  #   cr = CustomerRepository.new("./data/customers.csv")
  #
  #   assert_equal Array,         cr.all.class
  #   assert_equal 4985,          cr.all.count
  #   assert_instance_of Customer, cr.all.sample
  # end
  #
  # def test_it_finds_an_customer_by_id
  #   cr = CustomerRepository.new("./data/customers.csv")
  #
  #   assert_instance_of Customer, cr.find_by_id(26)
  #   assert_instance_of Customer, cr.find_by_id(77)
  #   assert_equal nil,           cr.find_by_id(1234567)
  # end
  #
  # def test_it_finds_all_customers_by_customer_id
  #   cr = CustomerRepository.new("./data/customers.csv")
  #
  #   assert_instance_of Customer, cr.find_all_by_customer_id(1).first
  #   assert_instance_of Customer, cr.find_all_by_customer_id(2).first
  #   assert_instance_of Customer, cr.find_all_by_customer_id(233).first
  #   assert_equal [],            cr.find_all_by_customer_id(4)
  # end
