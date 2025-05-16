require_relative '../../lib/receipt'

RSpec.describe Receipt do
  subject { Receipt }

  context '.create -:' do
    it 'sohuld create receipt for 1 item' do
      expected_result = [{"item": 'Milk', "quantity": 1, "price": 3.97, "remark": nil}]
      obj = subject.new(['milk'])
      result = obj.create
      expect(result).to eq(expected_result)
      expect(obj.instance_variable_get(:@total_price)).to eq(3.97)
      expect(obj.instance_variable_get(:@amount_saved)).to eq(0)
      expect(obj.instance_variable_get(:@invalid_items)).to eq([])
    end
    it 'should create receipt for qty > 1 with sale price applicable' do
      expected_result = [{"item": 'Milk', "quantity": 2, "price": 5.0, "remark": nil}]
      obj = subject.new(['milk','milk'])
      result = obj.create
      expect(result).to eq(expected_result)
      expect(obj.instance_variable_get(:@total_price)).to eq(5.0)
      expect(obj.instance_variable_get(:@amount_saved)).to eq(2.94)
      expect(obj.instance_variable_get(:@invalid_items)).to eq([])
    end
    it 'should create receipt for qty > 1 with sale price applicable with multiple item types' do
      items = ['milk','milk','bread','banana','bread','bread','bread','milk','apple']
      expected_result = [
        {"item": 'Milk', "quantity": 3, "price": 8.97, "remark": nil},
        {"item": 'Bread', "quantity": 4, "price": 8.17, "remark": nil},
        {"item": 'Apple', "quantity": 1, "price": 0.89, "remark": nil},
        {"item": 'Banana', "quantity": 1, "price": 0.99, "remark": nil}
        ]
      obj = subject.new(items)
      result = obj.create
      expect(result).to match_array(expected_result)
      expect(obj.instance_variable_get(:@total_price)).to eq(19.02)
      expect(obj.instance_variable_get(:@amount_saved)).to eq(3.45)
      expect(obj.instance_variable_get(:@invalid_items)).to eq([])
    end
  end

  context '.print_receipt -:' do
    it 'should print the given receipt' do
      output = StringIO.new
      $stdout = output
      items = ['milk','milk','bread','banana','bread','bread','bread','milk','apple']
      obj = subject.new(items)
      receipt = obj.create
      obj.print_receipt(receipt)
      $stdout = STDOUT
      printed = output.string
      expect(printed).to include('Item')
      expect(printed).to include('Milk')
      expect(printed).to include('Bread')
      expect(printed).to include('Apple')
      expect(printed).to include('Banana')
      expect(printed).to include('Total price : $19.02')
      expect(printed).to include('You saved $3.45 today')
    end
  end

end