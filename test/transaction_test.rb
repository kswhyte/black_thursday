require './test/test_helper'
require './lib/transaction'

class TransactionTest < Minitest::Test
  def transaction_test_setup
    [ Transaction.new({ :id                 => "777",
                        :invoice_id         => "4270",
                        :credit_card_number => "4268019568298476",
                        :credit_card_expiration_date => "0615",
                        :result             => "failed",
                        :created_at         => "2012-02-26 20:57:22 UTC",
                        :updated_at         => "2012-02-26 20:57:22 UTC" }),
      Transaction.new({ :id                 => "1111",
                        :invoice_id         => "1288",
                        :credit_card_number => "4252071231731132",
                        :credit_card_expiration_date => "0420",
                        :result             => "success",
                        :created_at         => "2012-02-26 20:57:33 UTC",
                        :updated_at         => "2012-02-26 20:57:33 UTC" }),
      Transaction.new({ :id                 => "3333",
                        :invoice_id         => "1240",
                        :credit_card_number => "4571715740366627",
                        :credit_card_expiration_date => "1117",
                        :result             => "success",
                        :created_at         => "2012-02-26 20:58:46 UTC",
                        :updated_at         => "2012-02-26 20:58:46 UTC" })]
  end

  def test_it_has_an_id
    transaction = transaction_test_setup

    assert_equal 777,  transaction[0].id
    assert_equal 1111, transaction[1].id
    assert_equal 3333, transaction[2].id
  end

  def test_it_has_an_invoice_id
    transaction = transaction_test_setup

    assert_equal 4270, transaction[0].invoice_id
    assert_equal 1288, transaction[1].invoice_id
    assert_equal 1240, transaction[2].invoice_id
  end

  def test_it_has_a_credit_card_number
    transaction = transaction_test_setup

    assert_equal "4268019568298476", transaction[0].credit_card_number
    assert_equal "4252071231731132", transaction[1].credit_card_number
    assert_equal "4571715740366627", transaction[2].credit_card_number
  end

  def test_it_has_a_credit_card_expiration_date
    transaction = transaction_test_setup

    assert_equal "0615", transaction[0].credit_card_expiration_date
    assert_equal "0420", transaction[1].credit_card_expiration_date
    assert_equal "1117", transaction[2].credit_card_expiration_date
  end

  def test_it_has_a_credit_card_expiration_date
    transaction = transaction_test_setup

    assert_equal :failed, transaction[0].result
    assert_equal :success, transaction[1].result
    assert_equal :success, transaction[2].result
  end

  def test_when_it_was_created
    transaction = transaction_test_setup

    time = Time.parse("2012-02-26 20:57:22 UTC")
    assert_equal time, transaction[0].created_at
    time = Time.parse("2012-02-26 20:57:33 UTC")
    assert_equal time, transaction[1].created_at
    time = Time.parse("2012-02-26 20:58:46 UTC")
    assert_equal time, transaction[2].created_at
  end

  def test_when_it_was_updated
    transaction = transaction_test_setup

    time = Time.parse("2012-02-26 20:57:22 UTC")
    assert_equal time, transaction[0].updated_at
    time = Time.parse("2012-02-26 20:57:33 UTC")
    assert_equal time, transaction[1].updated_at
    time = Time.parse("2012-02-26 20:58:46 UTC")
    assert_equal time, transaction[2].updated_at
  end
end
