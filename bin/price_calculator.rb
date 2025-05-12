require_relative '../receipt'

p "Please enter all items purchased separated by a comma"
begin
  inp = gets.chomp
  item_list = inp.split(',')
  item_list = item_list.map{|i| i.strip}

  obj = Receipt.new(item_list)
  receipt = obj.create
  obj.print_receipt(receipt,total_price,invalid_items)
rescue => e
  p "Error - #{e.message}"
end