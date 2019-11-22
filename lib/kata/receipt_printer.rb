class Kata::ReceiptPrinter
  def initialize(columns = 40)
    @columns = columns
  end

  def receipt_item_lines(item)
    price = format_price(item.total_price)
    quantity = self.class.present_quantity(item)
    name = item.product.name
    unit_price = format_price(item.price)

    whitespace_size = @columns - name.size - price.size
    line = name + self.class.whitespace(whitespace_size) + price + "\n"

    if item.quantity != 1
      line += "  " + unit_price + " * " + quantity + "\n"
    end

    return line
  end

  def receipt_discount_lines(discount)
    product_presentation = discount.product.name
    price_presentation = format_price(discount.discount_amount)
    description = discount.description
    whitespace = self.class.whitespace(
      @columns - 3 - product_presentation.size - description.size - price_presentation.size
    )

    return "#{description}(#{product_presentation})#{whitespace}-#{price_presentation}\n"
  end

  def print_receipt(receipt)
    result = ""
    receipt.items.each do |item|
      result.concat(receipt_item_lines(item))
    end

    receipt.discounts.each do |discount|
      result.concat(receipt_discount_lines(discount))
    end
    result.concat("\n")
    price_presentation = format_price(receipt.total_price.to_f)
    total = "Total: "
    whitespace = self.class.whitespace(@columns - total.size - price_presentation.size)
    result.concat(total, whitespace, price_presentation)
    result.to_s
  end

  def self.present_quantity(item)
    return Kata::ProductUnit::EACH == item.product.unit ? '%x' % item.quantity.to_i : '%.3f' % item.quantity
  end

  def self.whitespace(whitespace_size)
    whitespace = ''
    whitespace_size.times do
      whitespace.concat(' ')
    end
    return whitespace
  end

  private

  def format_price(price)
    "%.2f" % price
  end

end
