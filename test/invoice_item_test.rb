require './test/test_helper'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def invoice_item_test_setup
    [ InvoiceItem.new({ :id         => "3333",
                        :item_id    => "263403749",
                        :invoice_id => "754",
                        :quantity   => "2",
                        :unit_price => "31618",
                        :created_at => "2012-03-27 14:54:45 UTC",
                        :updated_at => "2012-03-27 14:54:45 UTC" }),
      InvoiceItem.new({ :id         => "11111",
                        :item_id    => "263397843",
                        :invoice_id => "2510",
                        :quantity   => "6",
                        :unit_price => "99023",
                        :created_at => "2012-03-27 14:56:10 UTC",
                        :updated_at => "2012-03-27 14:56:10 UTC" }),
      InvoiceItem.new({ :id         => "7777",
                        :item_id    => "263524340",
                        :invoice_id => "1755",
                        :quantity   => "2",
                        :unit_price => "92440",
                        :created_at => "2012-03-27 14:55:34 UTC",
                        :updated_at => "2012-03-27 14:55:34 UTC" })]
  end

  def test_it_has_an_id
    invoice_item = invoice_item_test_setup

    assert_equal 3333,  invoice_item[0].id
    assert_equal 11111, invoice_item[1].id
    assert_equal 7777,  invoice_item[2].id
  end

  def test_it_has_an_item_id
    invoice_item = invoice_item_test_setup

    assert_equal 263403749, invoice_item[0].item_id
    assert_equal 263397843, invoice_item[1].item_id
    assert_equal 263524340, invoice_item[2].item_id
  end

  def test_it_has_an_invoice_id
    invoice_item = invoice_item_test_setup

    assert_equal 754,  invoice_item[0].invoice_id
    assert_equal 2510, invoice_item[1].invoice_id
    assert_equal 1755, invoice_item[2].invoice_id
  end

  def test_it_has_a_quantity
    invoice_item = invoice_item_test_setup

    assert_equal 2, invoice_item[0].quantity
    assert_equal 6, invoice_item[1].quantity
    assert_equal 2, invoice_item[2].quantity
  end

  def test_it_has_a_unit_price
    invoice_item = invoice_item_test_setup

    assert_equal 316.18, invoice_item[0].unit_price
    assert_equal 990.23, invoice_item[1].unit_price
    assert_equal 924.40, invoice_item[2].unit_price
  end

  def test_when_it_was_created
    invoice_item = invoice_item_test_setup

    time = Time.parse("2012-03-27 14:54:45 UTC")
    assert_equal time, invoice_item[0].created_at
    time = Time.parse("2012-03-27 14:56:10 UTC")
    assert_equal time, invoice_item[1].created_at
    time = Time.parse("2012-03-27 14:55:34 UTC")
    assert_equal time, invoice_item[2].created_at
  end

  def test_when_it_was_updated
    invoice_item = invoice_item_test_setup

    time = Time.parse("2012-03-27 14:54:45 UTC")
    assert_equal time, invoice_item[0].updated_at
    time = Time.parse("2012-03-27 14:56:10 UTC")
    assert_equal time, invoice_item[1].updated_at
    time = Time.parse("2012-03-27 14:55:34 UTC")
    assert_equal time, invoice_item[2].updated_at
  end

  def test_it_converts_an_item_price_to_dollars
    invoice_item = invoice_item_test_setup

    assert_equal 316.18, invoice_item[0].unit_price_to_dollars
    assert_equal 990.23, invoice_item[1].unit_price_to_dollars
    assert_equal 924.40, invoice_item[2].unit_price_to_dollars
  end
end
