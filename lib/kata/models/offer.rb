class Kata::Offer
  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, argument)
    @offer_type = offer_type
    @argument = argument
    @product = product
  end

  def divider
    case offer_type
    when Kata::SpecialOfferType::THREE_FOR_TWO
      discount_divider = 3
    when Kata::SpecialOfferType::TWO_FOR_AMOUNT
      discount_divider = 2
    when Kata::SpecialOfferType:: FIVE_FOR_AMOUNT
      discount_divider = 5
    else
      discount_divider = 1
    end
  end

end

class Kata::ThreeForTwoOffer < Kata::Offer
  def initialize(product, argument)
    super('THREE_FOR_TWO', product, argument)
  end
end

class Kata::TenPercentDiscountOffer < Kata::Offer
  def initialize(product, argument)
    super('TEN_PERCENT_DISCOUNT', product, argument)
  end
end

class Kata::TwoForAmountOffer < Kata::Offer
  def initialize(product, argument)
    super('TWO_FOR_AMOUNT', product, argument)
  end
end

class Kata::FiveForAmountOffer < Kata::Offer
  def initialize(product, argument)
    super('FIVE_FOR_AMOUNT', product, argument)
  end
end
