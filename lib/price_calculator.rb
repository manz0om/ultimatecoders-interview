require_relative 'pricing_table_constant'

class PriceCalculator
  include PricingTableConstant

  def calculate(item,qty)
    item = item.to_sym 
    price = 0.0
    net_price = 0.0
    unless PRICING_TABLE[item].empty?
      unless PRICING_TABLE[item][:sale_price].empty?
        sale_quantity = PRICING_TABLE[item][:sale_price][:quantity]
        sale_price = PRICING_TABLE[item][:sale_price][:value]
        price = ((qty/sale_quantity).to_i * sale_price) + ((qty%sale_quantity) * PRICING_TABLE[item][:unit_price])
      else
        price = qty * PRICING_TABLE[item][:unit_price]
      end
      net_price = qty * PRICING_TABLE[item][:unit_price]
    else
      raise "Item - #{item} not present"
    end
    return price.round(2), (net_price-price).round(2)
  end
end