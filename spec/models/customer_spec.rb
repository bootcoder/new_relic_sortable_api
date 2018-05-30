require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'attrs' do
    let(:customer) {create(:customer, first_name: 'tom', last_name: 'tomtom')}

    it 'has a first_name' do
      expect(customer.first_name).to eq 'tom'
    end

    it 'has a last_name' do
      expect(customer.last_name).to eq 'tomtom'
    end

  end
end
