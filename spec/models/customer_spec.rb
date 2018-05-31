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

  describe '#by_first_or_last_name' do
    let!(:cust_1) {create(:customer, first_name: 'Aaron', last_name: 'Paulsen')}
    let!(:cust_2) {create(:customer, first_name: 'Dave', last_name: 'Smith')}
    let!(:cust_3) {create(:customer, first_name: 'Henry', last_name: 'Aaronson')}
    let!(:cust_4) {create(:customer, first_name: 'Iris', last_name: 'Lantrel')}
    let!(:cust_5) {create(:customer, first_name: 'Tracy', last_name: 'Tomay')}
    let!(:cust_6) {create(:customer, first_name: 'Jill', last_name: 'Smith')}

    it "returns results matching input" do
      expect(Customer.by_first_or_last_name('aa')).to eq [cust_1, cust_3]
      expect(Customer.by_first_or_last_name('Smith')).to eq [cust_2, cust_6]
      expect(Customer.by_first_or_last_name('r')).to eq [cust_1, cust_3, cust_4, cust_5]
    end
  end
end
