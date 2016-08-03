require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def merchant_test_setup
    [ Merchant.new({ :id => 12334115,
                     :name => "LolaMarleys",
                     :created_at => "2008-06-09 00:00:00 -0600",
                     :updated_at => "2015-04-16 00:00:00 -0600" }),
      Merchant.new({ :id => 12334132,
                     :name => "perlesemoi",
                     :created_at => "2009-03-21 00:00:00 -0600",
                     :updated_at => "2014-05-19 00:00:00 -0600" }),
      Merchant.new({ :id => 12334141,
                     :name => "jejum",
                     :created_at => "2007-06-25 00:00:00 -0600",
                     :updated_at => "2015-09-09 00:00:00 -0600"}) ]
  end

  def test_it_creates_a_merchant
    merchants = merchant_test_setup

    assert_instance_of Merchant, merchants[0]
    assert_instance_of Merchant, merchants[1]
    assert_instance_of Merchant, merchants[2]
  end

  def test_it_finds_a_merchant_id
    merchants = merchant_test_setup

    assert_equal 12334115, merchants[0].id
    assert_equal 12334132, merchants[1].id
    assert_equal 12334141, merchants[2].id
  end

  def test_it_finds_a_merchant_name
    merchants = merchant_test_setup

    assert_equal "LolaMarleys", merchants[0].name
    assert_equal "perlesemoi",  merchants[1].name
    assert_equal "jejum",       merchants[2].name
  end

  def test_it_finds_when_an_merchant_was_created
    merchant = merchant_test_setup

    assert_equal Time.parse("2008-06-09 00:00:00 -0600"), merchant[0].created_at
    assert_equal Time.parse("2009-03-21 00:00:00 -0600"), merchant[1].created_at
    assert_equal Time.parse("2007-06-25 00:00:00 -0600"), merchant[2].created_at
  end

  def test_it_finds_when_an_merchant_was_updated
    merchant = merchant_test_setup

    assert_equal Time.parse("2015-04-16 00:00:00 -0600"), merchant[0].updated_at
    assert_equal Time.parse("2014-05-19 00:00:00 -0600"), merchant[1].updated_at
    assert_equal Time.parse("2015-09-09 00:00:00 -0600"), merchant[2].updated_at
  end
end
