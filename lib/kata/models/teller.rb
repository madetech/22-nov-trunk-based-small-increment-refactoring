class Kata::Teller
  def initialize(catalog)
    @catalog = catalog
    @offers = {}
  end

  def add_special_offer(offer_type, product, argument)
    @offers[product] = Kata::Offer.new(offer_type, product, argument)
  end

  def checks_out_articles_from(the_cart)
    receipt = Kata::Receipt.new

    the_cart.items.each do |item|
      unit_price = @catalog.unit_price(item.product)
      price = item.quantity * unit_price
      receipt.add_product(item.product, item.quantity, unit_price, price)
    end

    the_cart.handle_offers(receipt, @offers, @catalog)

    receipt
  end
end
