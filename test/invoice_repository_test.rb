require './test/test_helper'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    invoice_repo = InvoiceRepository.new("./data/invoices.csv")

    assert_instance_of InvoiceRepository, invoice_repo
  end

  def test_it_populates_repository_with_invoices
    invoice_repo = InvoiceRepository.new("./data/invoices.csv")

    assert_equal 4985, invoice_repo.invoices.count
  end

  def test_it_returns_an_invoice_from_repository
    invoice_repo = InvoiceRepository.new("./data/invoices.csv")

    assert_instance_of Invoice, invoice_repo.invoices[7]
    assert_instance_of Invoice, invoice_repo.invoices[1]
    assert_instance_of Invoice, invoice_repo.invoices[11]
  end

  def test_it_returns_a_list_of_all_invoices
    invoice_repo = InvoiceRepository.new("./data/invoices.csv")

    assert_equal Array,         invoice_repo.all.class
    assert_equal 4985,          invoice_repo.all.count
    assert_instance_of Invoice, invoice_repo.all.sample
  end

  def test_it_finds_an_invoice_by_id
    invoice_repo = InvoiceRepository.new("./data/invoices.csv")

    assert_instance_of Invoice, invoice_repo.find_by_id(26)
    assert_instance_of Invoice, invoice_repo.find_by_id(77)
    assert_equal nil,           invoice_repo.find_by_id(1234567)
  end

  def test_it_finds_all_invoices_by_customer_id
    invoice_repo = InvoiceRepository.new("./data/invoices.csv")

    assert_instance_of Invoice, invoice_repo.find_all_by_customer_id(1).first
    assert_instance_of Invoice, invoice_repo.find_all_by_customer_id(2).first
    assert_instance_of Invoice, invoice_repo.find_all_by_customer_id(233).first
    assert_equal [],            invoice_repo.find_all_by_customer_id(4)
  end

  def test_it_finds_all_invoices_by_merchant_id
    invoice_repo = InvoiceRepository.new("./data/invoices.csv")

    assert_instance_of Invoice, invoice_repo.find_all_by_merchant_id(12335938).first
    assert_instance_of Invoice, invoice_repo.find_all_by_merchant_id(12337105).first
    assert_instance_of Invoice, invoice_repo.find_all_by_merchant_id(12335204).first
    assert_equal [],            invoice_repo.find_all_by_merchant_id(12335555)
  end

  def test_it_finds_all_invoices_by_status
    invoice_repo = InvoiceRepository.new("./data/invoices.csv")

    assert_instance_of Invoice, invoice_repo.find_all_by_status(:pending).first
    assert_instance_of Invoice, invoice_repo.find_all_by_status(:shipped).first
    assert_instance_of Invoice, invoice_repo.find_all_by_status(:returned).first
    assert_equal [],            invoice_repo.find_all_by_status(:delivered)
  end
end
