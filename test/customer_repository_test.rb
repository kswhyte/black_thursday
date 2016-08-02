require './test/test_helper'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_it_exists
    cr = CustomerRepository.new("./data/customers.csv")

    assert_instance_of CustomerRepository, cr
  end

  def test_it_populates_repository_with_customers
    cr = CustomerRepository.new("./data/customers.csv")

    assert_equal 1000, cr.customers.count
  end

  def test_it_does_not_error_on_bad_input
    cr = CustomerRepository.new("./bogus/file/path.csv")
    assert_equal Hash.new, cr.customers

    cr = CustomerRepository.new(true)
    assert_equal Hash.new, cr.customers

    cr = CustomerRepository.new(nil)
    assert_equal Hash.new, cr.customers
  end

  def test_it_returns_a_customer_from_repository
    cr = CustomerRepository.new("./data/customers.csv")

    assert_instance_of Customer, cr.customers[26]
  end

  def test_it_returns_a_list_of_all_customers
    cr = CustomerRepository.new("./data/customers.csv")

    assert_equal Array,          cr.all.class
    assert_equal 1000,           cr.all.count
    assert_instance_of Customer, cr.all.sample
  end

  def test_it_finds_a_customer_by_id
    cr = CustomerRepository.new("./data/customers.csv")

    assert_instance_of Customer, cr.find_by_id(9)
    assert_instance_of Customer, cr.find_by_id(306)
    assert_equal nil,            cr.find_by_id(1237)
  end

  def test_it_finds_all_customers_by_customer_first_name
    cr = CustomerRepository.new("./data/customers.csv")

    assert_instance_of Customer, cr.find_all_by_first_name("Marv").first
    assert_instance_of Customer, cr.find_all_by_first_name("Duncan").first
    assert_instance_of Customer, cr.find_all_by_first_name("Za").first
    assert_equal [],             cr.find_all_by_first_name("Kinan")
  end

  def test_it_finds_all_customers_by_customer_last_name
    cr = CustomerRepository.new("./data/customers.csv")

    assert_instance_of Customer, cr.find_all_by_last_name("Pfannerstill").first
    assert_instance_of Customer, cr.find_all_by_last_name("derhar").first
    assert_instance_of Customer, cr.find_all_by_last_name("Turc").first
    assert_equal [],             cr.find_all_by_last_name("Calaway")
  end
end
