class Kata::ShoppingCart
  attr_reader :items, :product_quantities

  def initialize
    @items = []
    @product_quantities = {}
  end

  def add_item(product)
    add_item_quantity(product, 1.0)
  end

  def add_item_quantity(product, quantity)
    @items << Kata::ProductQuantity.new(product, quantity)
    @product_quantities[product] = if @product_quantities.key?(product)
                                    @product_quantities[product] + quantity
                                  else
                                    quantity
                                  end
  end

  def handle_offers(receipt, offers, catalog)
    @product_quantities.keys.each do |product|
      quantity = @product_quantities[product].to_i
      if offers.key?(product)
        offer = offers[product]
        unit_price = catalog.unit_price(product)
        discount = nil
        x = 1
        if offer.offer_type == Kata::SpecialOfferType::THREE_FOR_TWO
          x = 3

        elsif offer.offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT
          x = 2
          if quantity >= 2
            total = offer.argument * quantity / x + quantity % 2 * unit_price
            discount_n = unit_price * quantity - total
            discount = Kata::Discount.new(product, "2 for " + offer.argument.to_s, discount_n)
          end

        end
        if offer.offer_type == Kata::SpecialOfferType:: FIVE_FOR_AMOUNT
          x = 5
        end
        number_of_x = quantity / x
        if offer.offer_type == Kata::SpecialOfferType::THREE_FOR_TWO && quantity > 2
          discount_amount = quantity * unit_price - ((number_of_x * 2 * unit_price) + quantity % 3 * unit_price)
          discount = Kata::Discount.new(product, "3 for 2", discount_amount)
        end
        if offer.offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
          discount = Kata::Discount.new(product, offer.argument.to_s + "% off", quantity * unit_price * offer.argument / 100.0)
        end
        if offer.offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT && quantity >= 5
          discount_total = unit_price * quantity - (offer.argument * number_of_x + quantity % 5 * unit_price)
          discount = Kata::Discount.new(product, x.to_s + " for " + offer.argument.to_s, discount_total)
        end

        receipt.add_discount(discount) if discount
      end
    end
  end
end
