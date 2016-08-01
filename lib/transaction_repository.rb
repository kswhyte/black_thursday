require_relative '../lib/transaction'
require './lib/file_extractor'

class TransactionRepository
  attr_reader :transactions

  def initialize(load_path, sales_engine_parent = nil)
    @sales_engine_parent = sales_engine_parent
    @transactions = {}
    if load_path.class == String && File.exist?(load_path)
      transactions_data = FileExtractor.extract_data(load_path)
      populate(transactions_data)
    end
  end

  def make_transaction(transaction_data)
    transactions[transaction_data[:id].to_i] = Transaction.new(transaction_data, self)
  end

  def populate(transactions_data)
    transactions_data.each do |transaction_data|
      make_transaction(transaction_data)
    end
  end

  def all
    transactions.values
  end

  def find_by_id(transaction_id)
    transactions[transaction_id]
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.values.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_result(result)
    transactions.values.find_all do |transaction|
      transaction.result == result
    end
  end
end
