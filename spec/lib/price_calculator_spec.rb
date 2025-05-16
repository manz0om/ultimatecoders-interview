require 'spec_helper'
require_relative '../../lib/price_calculator'

RSpec.describe PriceCalculator do
  subject { PriceCalculator.new }
  
  context 'item with sale price :' do
    it 'should return total price for 1 item' do        
      expect(subject.calculate('milk',1)).to eq([3.97,0])
    end
    it 'should return total price after discount for sale for quantity = 2' do
      expect(subject.calculate('milk',2)).to eq([5,2.94])
    end
    it 'should return total price after discount for sale for quantity > 2' do
      expect(subject.calculate('milk',5)).to eq([13.97,5.88])
    end
  end
  context 'item without sale price :' do
    it 'should return total price for 1 item' do
      expect(subject.calculate('banana',1)).to eq([0.99,0])
    end
    it 'should return total price for quantity > 1' do
      expect(subject.calculate('banana',2)).to eq([1.98,0])
    end
  end
  context 'item not in price table :' do
    it 'should raise error' do
      expect{ subject.calculate('mango',1) }.to raise_error{ 'Item - mango not present' }
    end
  end
end