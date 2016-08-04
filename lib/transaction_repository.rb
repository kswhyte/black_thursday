require_relative '../lib/transaction'
require_relative '../lib/file_extractor'

class TransactionRepository
  attr_reader :transactions

  def initialize(load_path, sales_engine_parent = nil)
    @sales_engine_parent = sales_engine_parent
    @transactions = {}
    populate(load_path)
  end

  def make_transaction(transaction_data)
    id = transaction_data[:id].to_i
    transactions[id] = Transaction.new(transaction_data, self)
  end

  def populate(load_path)
    if load_path.class == String && File.exist?(load_path)
      transactions_data = FileExtractor.extract_data(load_path)
      transactions_data.each do |transaction_data|
        make_transaction(transaction_data)
      end
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

  def find_all_by_credit_card_number(credit_card_number)
    transactions.values.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    transactions.values.find_all do |transaction|
      transaction.result == result
    end
  end

  def find_invoice_by_transaction_id(invoice_id)
    @sales_engine_parent.find_invoice_by_transaction_id(invoice_id)
  end

  def find_all_transactions_by_invoice_id(invoice_id)
    transactions.values.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def is_paid_in_full?(invoice_id)
    transactions = find_all_transactions_by_invoice_id(invoice_id)
    transactions.any? do |transaction|
      transaction.result == "success"
    end
  end

  def inspect
    # "#<#{self.class} #{@merchants.size} rows>"
  end
end
