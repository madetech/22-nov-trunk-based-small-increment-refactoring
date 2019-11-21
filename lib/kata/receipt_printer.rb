class Kata::ReceiptPrinter
  def initialize(columns = 40)
    @columns = columns
  end

  def print_receipt(receipt)
    result = ''
    receipt.items.each do |item|
      result.concat(receipt_item_lines(item))
    end

    receipt.discounts.each do |discount|
      result.concat(receipt_discount_lines(discount))
    end

    result.concat("\n")
    result.concat(receipt_last_line(receipt.total_price))
  end

  def present_quantity(item)
    Kata::ProductUnit::EACH == item.product.unit ? '%x' % item.quantity.to_i : '%.3f' % item.quantity
  end

  def whitespace(whitespace_size)
    ' ' * whitespace_size
  end

  private

  def receipt_item_lines(item)
    price = format_price(item.total_price)
    quantity = present_quantity(item)
    name = item.product.name
    unit_price = format_price(item.price)

    whitespace_size = @columns - name.size - price.size
    line = name + whitespace(whitespace_size) + price + "\n"

    line.concat("  #{unit_price} * #{quantity}\n") if item.quantity != 1

    line
  end

  def receipt_discount_lines(discount)
    product_presentation = discount.product.name
    discount_amount = format_price(discount.discount_amount)
    description = discount.description
    whitespace = whitespace(
      @columns - 3 - product_presentation.size - description.size - discount_amount.size
    )

    "#{description}(#{product_presentation})#{whitespace}-#{discount_amount}\n"
  end

  def receipt_last_line(total_price)
    price_presentation = format_price(total_price.to_f)
    total = 'Total: '
    whitespace = whitespace(
      @columns - total.size - price_presentation.size
    )

    "#{total}#{whitespace}#{price_presentation}"
  end

  def format_price(price)
    '%.2f' % price
  end
end
