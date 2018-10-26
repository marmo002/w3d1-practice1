require './product.rb'

class Cart

  # CLASS METHODS

  # INITIALIZE METHODS
  def initialize
    @list = []
  end

  # READERS
  def list
    @list
  end

  # WRITTERS

  #INSTANCE METHODS
  def add(product, quantity = 1)
    quantity.times do
      @list << product # will return @@list
    end
    @list
  end

  def remove(product)
    @list.delete(product) # will return product
  end

  def total_before_tax
    list.map { |product|
      product.base_price
    }.sum
  end

  def total_after_tax
    list.map { |product|
      product.total_price
    }.sum.round(2)
  end

  def most_expensive
    product = list.max { |a, b| a.base_price <=> b.base_price }
    "The most expensive product is #{product.name} at $#{product.base_price}"
  end

end

butter = Product.new("margarine", 2.25, "standard")
milk = Product.new("milk", 5.75, "standard")
iceCake = Product.new("Ice Cake", 40.50, "exempt")
beer = Product.new("Corona", 4.5, "imported")
tenderloin = Product.new("Beef Tenderloin", 115.50, "standard")
tenderloin2 = Product.new("Tenderloin", 115.50, "standard")

my_cart = Cart.new
puts "Butter total price is: $#{butter.total_price}"
puts
puts "Add product to cart"
my_cart.add(butter, 2)
my_cart.add(milk)
my_cart.add(iceCake, 2)
my_cart.add(tenderloin)
my_cart.add(beer)
puts my_cart.list.inspect
puts
# puts "Remove product from cart"
# my_cart.remove(butter)
# puts my_cart.list.inspect
puts "Total of products before taxes"
puts my_cart.total_before_tax.inspect
puts
puts "Total of products after taxes"
puts my_cart.total_after_tax.inspect
puts
puts my_cart.most_expensive
