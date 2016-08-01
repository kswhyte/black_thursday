require './test/test_helper'
require './lib/invoice'

class InvoiceTest < Minitest::Test
  def invoice_test_setup
    [ Invoice.new({  :id          => "998",
                     :customer_id => "192",
                     :merchant_id => "12336161",
                     :status      => "shipped",
                     :created_at  => "2009-06-19",
                     :updated_at  => "2012-03-07"  }),

      Invoice.new({  :id          => "334",
                     :customer_id => "69",
                     :merchant_id => "12334832",
                     :status      => "shipped",
                     :created_at  => "2007-07-08",
                     :updated_at  => "2015-01-16"  }),

      Invoice.new({  :id          => "445",
                     :customer_id => "85",
                     :merchant_id => "12334742",
                     :status      => "returned",
                     :created_at  => "2007-10-21",
                     :updated_at  => "2008-08-29"  }) ]
  end

  def test_it_has_an_id
    invoice = invoice_test_setup

    assert_equal 998, invoice[0].id
    assert_equal 334, invoice[1].id
    assert_equal 445, invoice[2].id
  end

  def test_it_has_a_customer_id
    invoice = invoice_test_setup

    assert_equal 192, invoice[0].customer_id
    assert_equal 69,  invoice[1].customer_id
    assert_equal 85,  invoice[2].customer_id
  end

  def test_it_has_a_merchant_id
    invoice = invoice_test_setup

    assert_equal 12336161, invoice[0].merchant_id
    assert_equal 12334832, invoice[1].merchant_id
    assert_equal 12334742, invoice[2].merchant_id
  end

  def test_it_has_a_status
    invoice = invoice_test_setup

    assert_equal :shipped,  invoice[0].status
    assert_equal :shipped,  invoice[1].status
    assert_equal :returned, invoice[2].status
  end

  def test_when_it_was_created
    invoice = invoice_test_setup

    assert_equal Time.parse("2009-06-19"), invoice[0].created_at
    assert_equal Time.parse("2007-07-08"), invoice[1].created_at
    assert_equal Time.parse("2007-10-21"), invoice[2].created_at
  end

  def test_when_it_was_updated
    invoice = invoice_test_setup

    assert_equal Time.parse("2012-03-07"), invoice[0].updated_at
    assert_equal Time.parse("2015-01-16"), invoice[1].updated_at
    assert_equal Time.parse("2008-08-29"), invoice[2].updated_at
  end
end
