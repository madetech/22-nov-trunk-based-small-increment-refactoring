class Kata::ShoppingCart
  DEFAULT_QUANTITY = 1

  attr_reader :items, :product_quantities

  def initialize
    @items = []
    @product_quantities = {}
  end

  def add_item(product)
    add_item_quantity(product, DEFAULT_QUANTITY)
  end

  def total_item_quantity(product, quantity)
     @product_quantities.key?(product) ? @product_quantities[product] + quantity : quantity
  end

  def add_item_quantity(product, quantity)
    @items << Kata::ProductQuantity.new(product, quantity)
    @product_quantities[product] = total_item_quantity(product, quantity)
  end

  def three_for_two(quantity, unit_price, number_of_discount_divider, product)
    discount_amount = quantity * unit_price - ((number_of_discount_divider * 2 * unit_price) + quantity % 3 * unit_price)
    discount = Kata::Discount.new(product, "3 for 2", discount_amount)
  end

  def ten_percent(product, offer, quantity, unit_price)
    discount = Kata::Discount.new(product, offer.argument.to_s + "% off", quantity * unit_price * offer.argument / 100.0)
  end 

  def awful_offer_handling_hack!(receipt, offers, catalog)
    @product_quantities.keys.each do |product|
      quantity = @product_quantities[product].to_i
      if offers.key?(product)
        offer = offers[product]
        unit_price = catalog.unit_price(product)
        discount_divider = 1

        case offer.offer_type
        when Kata::SpecialOfferType::THREE_FOR_TWO
          discount_divider = 3
        when Kata::SpecialOfferType::TWO_FOR_AMOUNT
          discount_divider = 2
          if quantity >= 2
            total = offer.argument * quantity / discount_divider + quantity % 2 * unit_price
            discount_n = unit_price * quantity - total
            discount = Kata::Discount.new(product, "2 for " + offer.argument.to_s, discount_n)
          end
        when Kata::SpecialOfferType:: FIVE_FOR_AMOUNT
          discount_divider = 5
        end

        number_of_discount_divider = quantity / discount_divider

        if offer.offer_type == Kata::SpecialOfferType::THREE_FOR_TWO && quantity > 2
          discount = three_for_two(quantity, unit_price, number_of_discount_divider, product)
        end
        if offer.offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
          discount = ten_percent(product, offer, quantity, unit_price)
        end
        if offer.offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT && quantity >= 5
          discount_total = unit_price * quantity - (offer.argument * number_of_discount_divider + quantity % 5 * unit_price)
          discount = Kata::Discount.new(product, discount_divider.to_s + " for " + offer.argument.to_s, discount_total)
        end

        receipt.add_discount(discount) if discount
      end
    end
  end
end
