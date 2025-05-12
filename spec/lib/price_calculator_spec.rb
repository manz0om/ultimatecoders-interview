require 'spec_helper'
require_relative '../../lib/price_calculator'

RSpec.describe PriceCalculator do
  subject { PriceCalculator.new }
  
  context 'item with sale price :' do
    it 'should return total price for 1 item' do        
      expect(subject.calculate('milk',1)).to eq([3.97,0])
    end
    it 'should return total price after discount for sale' do
      expect(subject.calculate('milk',2)).to eq([5,2.94])
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
end