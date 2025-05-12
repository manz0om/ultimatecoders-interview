require_relative 'price_calculator'

class Receipt
  attr_accessor :items
  def initialize(items = [])
    @items = items
    @total_price = 0.0
    @amount_saved = 0.0
    @invalid_items = []
  end

  def create
    quantity = {}
    items.each do |item|
      quantity[item] ||= 0
      quantity[item] += 1      
    end
    receipt = []
    quantity.each do |item,qty|
      price = 0.0
      begin
        price,savings = PriceCalculator.new.calculate(item,qty)
      rescue => e
        @invalid_items << {"item": item.capitalize, "quantity": qty, "price": 0.0, "remark": e.message}
        next
      end
      @total_price += price
      @amount_saved += savings
      receipt << {"item": item.capitalize, "quantity": qty, "price": price, "remark": nil}
    end
    return receipt
  end

  def print(receipt)
    header = "Item"+ " "*12 + "Quantity" + " "*12 + "Price"
    divider = "-" * 45
    puts header
    puts divider
    receipt.each do |row|
      r = row[:item]+ " "*12 + row[:quantity]+ " "*12 + "$"+row[:price]
      puts r
    end
    puts ""
    puts "Total price : $#{@total_price}"
    puts "You saved $#{@amount_saved} today"
  end
end