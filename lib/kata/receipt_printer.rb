class Kata::ReceiptPrinter
  def initialize(columns = 40)
    @columns = columns
  end

  def print_receipt(receipt)
    [
      presentable_receipt_items(receipt.items),
      presentable_discounts(receipt.discounts),
      "\n",
      presentable_totals(receipt.total_price)
    ].join('')
  end

  private

  def whitespace(whitespace_size)
    ' ' * whitespace_size
  end

  def presentable_discounts(discounts)
    discounts.map { |discount| receipt_discount_lines(discount) }.join('')
  end

  def presentable_receipt_items(items)
    items.map { |item| presentable_receipt_item(item) }.join('')
  end

  def presentable_receipt_item(item)
    [
      present_in_two_columns(item.product_name, format_price(item.total_price)),
      presentable_receipt_price_workings_out(item)
    ].join('')
  end

  def presentable_receipt_price_workings_out(item)
    return '' unless item.multiple?
    "  #{format_price(item.price)} * #{present_quantity(item)}\n"
  end

  def present_in_two_columns(left, right)
    whitespace_size = @columns - left.size - right.size
    "#{left}#{whitespace(whitespace_size)}#{right}\n"
  end

  def present_quantity(item)
    Kata::ProductUnit::EACH == item.product.unit ? '%x' % item.quantity.to_i : '%.3f' % item.quantity
  end

  def receipt_discount_lines(discount)
    product_name = discount.product.name
    discount_amount = format_price(discount.discount_amount)
    description = discount.description
    whitespace = whitespace(
      @columns - 3 - product_name.size - description.size - discount_amount.size
    )

    "#{description}(#{product_name})#{whitespace}-#{discount_amount}\n"
  end

  def presentable_totals(total_price)
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
