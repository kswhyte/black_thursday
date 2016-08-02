require './test/test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test
  def customer_test_setup
    [ Customer.new({  :id         => "2",
                      :first_name => "Cecelia",
                      :last_name  => "Osinski",
                      :created_at => "2012-03-27 14:54:10 UTC",
                      :updated_at => "2012-03-27 14:54:10 UTC"  }),

      Customer.new({  :id         => "56",
                      :first_name => "Eleazar",
                      :last_name  => "Wisozk",
                      :created_at => "2012-03-27 14:54:22 UTC",
                      :updated_at => "2012-03-27 14:54:22 UTC"  }),

      Customer.new({  :id         => "801",
                      :first_name => "Branson",
                      :last_name  => "Cummerata",
                      :created_at => "2012-03-27 14:57:26 UTC",
                      :updated_at => "2012-03-27 14:57:26 UTC"  }), ]
  end

  def test_it_has_an_id
    customer = customer_test_setup

    assert_equal 2, customer[0].id
    assert_equal 56, customer[1].id
    assert_equal 801, customer[2].id
  end

  def test_it_has_a_first_name
    customer = customer_test_setup

    assert_equal "Cecelia",  customer[0].first_name
    assert_equal "Eleazar",  customer[1].first_name
    assert_equal "Branson",  customer[2].first_name
  end

  def test_it_has_a_last_name
    customer = customer_test_setup

    assert_equal "Osinski",    customer[0].last_name
    assert_equal "Wisozk",     customer[1].last_name
    assert_equal "Cummerata",  customer[2].last_name
  end

  def test_when_it_was_created
    customer = customer_test_setup

    assert_equal Time.parse("2012-03-27 14:54:10 UTC"), customer[0].created_at
    assert_equal Time.parse("2012-03-27 14:54:22 UTC"), customer[1].created_at
    assert_equal Time.parse("2012-03-27 14:57:26 UTC"), customer[2].created_at
  end

  def test_when_it_was_updated
    customer = customer_test_setup

    assert_equal Time.parse("2012-03-27 14:54:10 UTC"), customer[0].updated_at
    assert_equal Time.parse("2012-03-27 14:54:22 UTC"), customer[1].updated_at
    assert_equal Time.parse("2012-03-27 14:57:26 UTC"), customer[2].updated_at
  end
end
