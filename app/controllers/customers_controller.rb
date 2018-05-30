class CustomersController < ApplicationController

  def index
    @customers = Customer.all.includes(:company)

    if customer_params[:name] && customer_params[:name] != ''
      @customers = Customer.by_first_or_last_name(customer_params[:name])
    end

    if customer_params[:company] && customer_params[:company] != ''
      @customers = @customers.reject {|cust| cust.company.name != customer_params[:company]}
    end

    @customers = what_the_sort!(customer_params[:sort_by])
    render json: @customers
  end

  private

  def customer_params
    params.permit(:name, :company, :sort_by)
  end

  def what_the_sort!(sort_param)
    @sort_by = sort_param || 'last_name_ascd'
    # NOTE: There is no fall through case here as the default is defined above.
    case @sort_by
    when 'first_name_ascd'
      return @customers.sort_by {|cust| cust.first_name.downcase}
    when 'first_name_desc'

      return @customers.sort_by {|cust| cust.first_name.downcase}.reverse
    when 'last_name_ascd'
      return @customers.sort_by {|cust| cust.last_name.downcase}
    when 'last_name_desc'
      return @customers.sort_by {|cust| cust.last_name.downcase}.reverse
    when 'company_name_ascd'
      return @customers.sort_by {|cust| cust.company.name.downcase}
    when 'company_name_desc'
      return @customers.sort_by {|cust| cust.company.name.downcase}.reverse
    end
  end

end
