require 'rails_helper'

RSpec.describe CustomersController do
  describe '#INDEX' do
    let!(:tom) {create(:customer, first_name: 'Tom', last_name: 'Tomtano')}
    let!(:tina) {create(:customer, first_name: 'tina', last_name: 'Smith')}

    it 'renders all customers' do
      get :index
      expect(assigns(:customers)).to eq [tina, tom]
    end

    context 'searchable by name' do

      it 'first_name' do
        get :index, {params: {name: 't'}}
        expect(assigns(:customers)).to eq [tina, tom]

        get :index, {params: {name: 'ti'}}
        expect(assigns(:customers)).to eq [tina]

        get :index, {params: {name: 'to'}}
        expect(assigns(:customers)).to eq [tom]
      end

      it 'last_name' do
        get :index, {params: {name: 'smith'}}
        expect(assigns(:customers)).to eq [tina]

        get :index, {params: {name: 'tomta'}}
        expect(assigns(:customers)).to eq [tom]
      end

      it 'renders names regardless of input case' do
        get :index, {params: {name: 'To'}}
        expect(assigns(:customers)).to eq [tom]

        get :index, {params: {name: 'TO'}}
        expect(assigns(:customers)).to eq [tom]

        get :index, {params: {name: 'tINa'}}
        expect(assigns(:customers)).to eq [tina]
      end

      it 'renders no results when no matches are found' do
        get :index, {params: {name: '12309'}}
        expect(assigns(:customers)).to eq []

        get :index, {params: {name: 'Mike'}}
        expect(assigns(:customers)).to eq []

        get :index, {params: {name: 'Wazowski'}}
        expect(assigns(:customers)).to eq []
      end

      it 'renders all customers when given an empty string' do
        get :index, {params: {name: ''}}
        expect(assigns(:customers)).to eq [tina, tom]
      end
    end

    context 'searchable by Company' do
      let!(:company_1) {create(:company_with_customers)}
      let!(:company_2) {create(:company_with_customers)}

      it 'renders all customers when no company given' do
        get :index, {params: {company: ''}}
        expect(assigns(:customers).length).to eq 12
      end

      it 'renders only customers for a given company' do
        get :index, {params: {company: company_1.name}}
        expect(assigns(:customers).all? {|cust| cust.company.name == company_1.name}).to be_truthy
      end
    end

    context 'sortable' do
      let!(:company_1) {create(:company_with_customers)}
      it 'sorts by first_name ascending' do
        sort_first_name = Customer.all.sort_by {|cust| cust.first_name.downcase}
        get :index, {params: {sort_by: 'first_name_ascn'}}
        expect(assigns(:customers).to_a).to eq sort_first_name
      end

      it 'sorts by first_name descending' do
        sort_first_name = Customer.all.sort_by {|cust| cust.first_name.downcase}.reverse
        get :index, {params: {sort_by: 'first_name_desc'}}
        expect(assigns(:customers).to_a).to eq sort_first_name
      end

      it 'sorts by last_name ascending' do
        sort_last_name = Customer.all.sort_by {|cust| cust.last_name.downcase}
        get :index, {params: {sort_by: 'last_name_ascn'}}
        expect(assigns(:customers).to_a).to eq sort_last_name
      end

      it 'sorts by last_name descending' do
        sort_last_name = Customer.all.sort_by {|cust| cust.last_name.downcase}.reverse
        get :index, {params: {sort_by: 'last_name_desc'}}
        expect(assigns(:customers).to_a).to eq sort_last_name
      end

      it 'sorts by company_name ascending' do
        sort_company_name = Customer.all.sort_by {|cust| cust.company.name.downcase}
        get :index, {params: {sort_by: 'company_name_ascn'}}
        expect(assigns(:customers).to_a).to eq sort_company_name
      end

      it 'sorts by company_name descending' do
        sort_company_name = Customer.all.sort_by {|cust| cust.company.name.downcase}.reverse
        get :index, {params: {sort_by: 'company_name_desc'}}
        expect(assigns(:customers).to_a).to eq sort_company_name
      end

      it 'sorts inside a search' do
        sort_company_name = Customer.all.sort_by {|cust| cust.company.name.downcase}.reverse
        sort_company_name = sort_company_name.reject {|cust| cust.company.name != company_1.name}
        get :index, {params: {company: company_1.name, sort_by: 'company_name_desc'}}
        expect(assigns(:customers).to_a).to eq sort_company_name
      end
    end

  end
end
