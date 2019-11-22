class Kata::Teller
  def initialize(catalog)
    @catalog = catalog
    @offers = {}
  end

  def add_special_offer(offer_type, product, argument)
    @offers[product] = Kata::Offer.new(offer_type, product, argument)
  end

  def boop_all_items_in(the_cart)
    Kata::Receipt.new.tap do |receipt|
      the_cart.items.each do |item|
        unit_price = @catalog.unit_price(item.product)
        price = item.quantity * unit_price
        receipt.add_product(item.product, item.quantity, unit_price, price)
      end

      the_cart.awful_offer_handling_hack(receipt, @offers, @catalog)
    end
  end
end
