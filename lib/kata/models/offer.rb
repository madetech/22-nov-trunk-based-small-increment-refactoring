class Kata::Offer
  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, argument)
    @offer_type = offer_type
    @argument = argument
    @product = product
  end

  def applies?(_)
    false
  end
end

class Kata::ThreeForTwoOffer < Kata::Offer
  def initialize(product, argument)
    super(Kata::SpecialOfferType::THREE_FOR_TWO, product, argument)
  end

  def divider
    3
  end
end

class Kata::TenPercentDiscountOffer < Kata::Offer
  def initialize(product, argument)
    super(Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT, product, argument)
  end

  def divider
    1
  end
end

class Kata::TwoForAmountOffer < Kata::Offer
  def initialize(product, argument)
    super(Kata::SpecialOfferType::TWO_FOR_AMOUNT, product, argument)
  end

  def divider
    2
  end

  def applies?(quantity)
    quantity >= 2
  end
end

class Kata::FiveForAmountOffer < Kata::Offer
  def initialize(product, argument)
    super(Kata::SpecialOfferType::FIVE_FOR_AMOUNT, product, argument)
  end

  def divider
    5
  end
end
