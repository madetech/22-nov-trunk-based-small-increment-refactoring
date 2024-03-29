require_relative './test_helper'

class SupermarketTest < Minitest::Test
  include Approvals

  cover "Kata*"

  def setup
    @catalog = FakeCatalog.new
    @teller = Kata::Teller.new(@catalog)
    @the_cart = Kata::ShoppingCart.new

    @toothbrush = Kata::Product.new("toothbrush", Kata::ProductUnit::EACH)
    @catalog.add_product(@toothbrush, 0.99)
    @rice = Kata::Product.new("rice", Kata::ProductUnit::EACH)
    @catalog.add_product(@rice, 2.99)
    @apples = Kata::Product.new("apples", Kata::ProductUnit::KILO)
    @catalog.add_product(@apples, 1.99)
    @cherry_tomatoes = Kata::Product.new("cherry tomato box", Kata::ProductUnit::EACH)
    @catalog.add_product(@cherry_tomatoes, 0.69)
  end

  def test_an_empty_shopping_cart_should_cost_nothing
    receipt = @teller.boop_all_items_in(@the_cart)
    verify_output_matches_text Kata::ReceiptPrinter.new(40).print_receipt(receipt)
  end

  def test_one_normal_item
    @the_cart.add_item(@toothbrush)
    receipt = @teller.boop_all_items_in(@the_cart)
    verify_output_matches_text Kata::ReceiptPrinter.new(40).print_receipt(receipt)
  end

  def test_two_normal_items
    @the_cart.add_item(@toothbrush)
    @the_cart.add_item(@rice)
    receipt = @teller.boop_all_items_in(@the_cart)
    verify_output_matches_text Kata::ReceiptPrinter.new(40).print_receipt(receipt)
  end

  def test_buy_two_get_one_free
    3.times { @the_cart.add_item(@toothbrush) }
    verify_output_matches_text Kata::ReceiptPrinter.new(40).print_receipt(add_toothbrush_discount_to_receipt(@the_cart))
  end

  def test_buy_five_get_one_free 
    5.times { @the_cart.add_item(@toothbrush) }
    verify_output_matches_text Kata::ReceiptPrinter.new(40).print_receipt(add_toothbrush_discount_to_receipt(@the_cart))
  end

  def test_percent_discount
    @the_cart.add_item(@rice)
    @teller.add_special_offer(Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT, @rice, 10.0)
    receipt = @teller.boop_all_items_in(@the_cart)
    verify_output_matches_text Kata::ReceiptPrinter.new(40).print_receipt(receipt)
  end

  def test_x_for_y_discount
    2.times{ @the_cart.add_item(@cherry_tomatoes) }
    @teller.add_special_offer(Kata::SpecialOfferType::TWO_FOR_AMOUNT, @cherry_tomatoes, 0.99)
    receipt = @teller.boop_all_items_in(@the_cart)
    verify_output_matches_text Kata::ReceiptPrinter.new(40).print_receipt(receipt)
  end

  def test_loose_weight_product
    @the_cart.add_item_quantity(@apples, 0.5)
    verify_output_matches_text Kata::ReceiptPrinter.new(40).print_receipt(add_apple_offer_five_for_amount)

  end

  def test_five_for_y_discount
    @the_cart.add_item_quantity(@apples, 5)
    verify_output_matches_text Kata::ReceiptPrinter.new(40).print_receipt(add_apple_offer_five_for_amount)
  end

  def test_five_for_y_discount_with_six
    @the_cart.add_item_quantity(@apples, 6)
    verify_output_matches_text Kata::ReceiptPrinter.new(40).print_receipt(add_apple_offer_five_for_amount)

  end

  def test_five_for_y_discount_with_sixteen
    @the_cart.add_item_quantity(@apples, 16)
    verify_output_matches_text Kata::ReceiptPrinter.new(40).print_receipt(add_apple_offer_five_for_amount)

  end

  def test_five_for_y_discount_with_four
    @the_cart.add_item_quantity(@apples, 4)
    verify_output_matches_text Kata::ReceiptPrinter.new(40).print_receipt(add_apple_offer_five_for_amount)

  end

  def add_apple_offer_five_for_amount
    @teller.add_special_offer(Kata::SpecialOfferType::FIVE_FOR_AMOUNT, @apples, 6.99)
    @teller.boop_all_items_in(@the_cart)
  end

  def add_toothbrush_discount_to_receipt(the_cart)
    @teller.add_special_offer(Kata::SpecialOfferType::THREE_FOR_TWO, @toothbrush, @catalog.unit_price(@toothbrush))
    @teller.boop_all_items_in(@the_cart)
  end
end
