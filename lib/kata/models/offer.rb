class Kata::Offer
  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, argument)
    @offer_type = offer_type
    @argument = argument
    @product = product
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
