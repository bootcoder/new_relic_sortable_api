require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'attrs' do
    let(:company) {create(:company_with_customers)}

    it 'has a name' do
      expect(company.name).to eq "Tom's Diner"
    end

    it 'has 5 customers' do
      expect(company.customers.count).to eq 5
    end

  end
end
