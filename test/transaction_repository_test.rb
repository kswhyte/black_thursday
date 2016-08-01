require './test/test_helper'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def test_it_exists
    tr = TransactionRepository.new("./test/fixtures/200transactions.csv")

    assert_instance_of TransactionRepository, tr
  end

  def test_it_populates_repository_with_transactions
    tr = TransactionRepository.new("./test/fixtures/200transactions.csv")

    assert_equal 200, tr.transactions.count
  end

  def test_it_does_not_error_on_bad_input
    tr = TransactionRepository.new("./bogus/file/path.csv")
    assert_equal Hash.new, tr.transactions

    tr = TransactionRepository.new(true)
    assert_equal Hash.new, tr.transactions

    tr = TransactionRepository.new(nil)
    assert_equal Hash.new, tr.transactions
  end

  def test_it_returns_an_transaction_from_repository
    tr = TransactionRepository.new("./test/fixtures/200transactions.csv")

    assert_instance_of Transaction, tr.transactions[99]
  end

  def test_it_returns_a_list_of_all_transactions
    tr = TransactionRepository.new("./test/fixtures/200transactions.csv")

    assert_equal Array,             tr.all.class
    assert_equal 200,               tr.all.count
    assert_instance_of Transaction, tr.all.sample
  end

  def test_it_finds_a_transaction_by_id
    tr = TransactionRepository.new("./test/fixtures/200transactions.csv")

    assert_instance_of Transaction, tr.find_by_id(1)
    assert_equal 4239,              tr.find_by_id(100).invoice_id
    assert_equal nil,               tr.find_by_id(201)
  end

  def test_it_finds_all_transactions_by_item_id
    tr = TransactionRepository.new("./test/fixtures/200transactions.csv")

    assert_equal 1,  tr.find_all_by_invoice_id(46).count
    assert_equal 2,  tr.find_all_by_invoice_id(2247).count
    assert_equal [], tr.find_all_by_invoice_id(8675309)
  end

  def test_it_finds_all_transactions_by_result
    tr = TransactionRepository.new("./test/fixtures/200transactions.csv")

    assert_equal 38,  tr.find_all_by_result("failed").count
    assert_equal 162, tr.find_all_by_result("success").count
    assert_equal [],  tr.find_all_by_result("test")
  end
end
