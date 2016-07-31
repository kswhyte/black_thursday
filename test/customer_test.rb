require './test/test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test
  def customer_test_setup
    [ Customer.new({  :id          => "998",
                     :customer_id => "192",
                     :merchant_id => "12336161",
                     :status      => "shipped",
                     :created_at  => "2009-06-19",
                     :updated_at  => "2012-03-07"  }),

      Customer.new({  :id          => "334",
                     :customer_id => "69",
                     :merchant_id => "12334832",
                     :status      => "shipped",
                     :created_at  => "2007-07-08",
                     :updated_at  => "2015-01-16"  }),

      Customer.new({  :id          => "445",
                     :customer_id => "85",
                     :merchant_id => "12334742",
                     :status      => "returned",
                     :created_at  => "2007-10-21",
                     :updated_at  => "2008-08-29"  }) ]
  end

  def test_it_has_an_id
    customer = customer_test_setup

    assert_equal 998, customer[0].id
    assert_equal 334, customer[1].id
    assert_equal 445, customer[2].id
  end

  # def test_it_has_a_customer_id
  #   customer = customer_test_setup
  #
  #   assert_equal 192, customer[0].customer_id
  #   assert_equal 69,  customer[1].customer_id
  #   assert_equal 85,  customer[2].customer_id
  # end
  #
  # def test_it_has_a_merchant_id
  #   customer = customer_test_setup
  #
  #   assert_equal 12336161, customer[0].merchant_id
  #   assert_equal 12334832, customer[1].merchant_id
  #   assert_equal 12334742, customer[2].merchant_id
  # end
