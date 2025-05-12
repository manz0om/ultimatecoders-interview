require_relative '../../lib/receipt'

RSpec.describe Receipt do
  subject { Receipt }

  context '.create -:' do
    it 'sohuld create receipt for 1 item' do
      result = [{"item": 'Milk', "quantity": 1, "price": 3.97, "remark": nil}]
      expect(subject.new(['milk']).create).to eq(result)
    end
    it 'should create receipt for qty > 1 with sale price applicable' do
      result = [{"item": 'Milk', "quantity": 2, "price": 5.0, "remark": nil}]
      expect(subject.new(['milk','milk']).create).to eq(result)
    end
  end
end