Kata::ReceiptItem = Struct.new(:product, :quantity, :price, :total_price) do
  undef :product=, :quantity=, :price=, :total_price=

  def product_name
    product.name
  end

  def multiple?
    quantity != 1
  end
end
