require './test/test_helper'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def test_it_exists
    iir = InvoiceItemRepository.new("./test/fixtures/200invitms.csv")

    assert_instance_of InvoiceItemRepository, iir
  end

  def test_it_populates_repository_with_invoice_items
    iir = InvoiceItemRepository.new("./test/fixtures/200invitms.csv")

    assert_equal 200, iir.invoice_items.count
  end

  def test_it_returns_an_invoice_item_from_repository
    iir = InvoiceItemRepository.new("./test/fixtures/200invitms.csv")

    assert_instance_of InvoiceItem, iir.invoice_items[99]
  end

  def test_it_returns_a_list_of_all_invoice_items
    iir = InvoiceItemRepository.new("./test/fixtures/200invitms.csv")

    assert_equal Array,             iir.all.class
    assert_equal 200,               iir.all.count
    assert_instance_of InvoiceItem, iir.all.sample
  end

  def test_it_finds_an_invoice_item_by_id
    iir = InvoiceItemRepository.new("./test/fixtures/200invitms.csv")

    assert_instance_of InvoiceItem, iir.find_by_id(1)
    assert_equal 263406625,         iir.find_by_id(100).item_id
    assert_equal nil,               iir.find_by_id(201)
  end

  # def test_it_finds_all_invoice_items_by_item_id
  #   iir = InvoiceItemRepository.new("./test/fixtures/200invitms.csv")
  #
  # end
end
