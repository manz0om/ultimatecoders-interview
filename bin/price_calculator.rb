require_relative '../lib/receipt'

p "Please enter all items purchased separated by a comma"
begin
  inp = gets.chomp
  item_list = inp.split(',')
  item_list = item_list.map{|i| i.strip.downcase}

  obj = Receipt.new(item_list)
  receipt = obj.create
  obj.print_receipt(receipt)
rescue => e
  p "Error - #{e.message}"
end