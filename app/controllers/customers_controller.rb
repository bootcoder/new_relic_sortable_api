class CustomersController < ApplicationController

  def index
    @customers = Customer.all.includes(:company)
    @params = {sort_by: customer_params[:sort_by] || 'last_name_ascn',
               name:    customer_params[:name]    || '',
               company: customer_params[:company] || 'all'}

    if @params[:name] && @params[:name] != ''
      @customers = Customer.by_first_or_last_name(@params[:name])
    end

    # NOTE: Started covering edge cases here but decided on the whitelist approach
    # This accomplishes the same result while being much more extensible.
    # if @params[:company] && @params[:company] != 'all' && @params[:company] != ''
    if Company.all.pluck(:name).include? @params[:company]
      @customers = @customers.reject {|cust| cust.company.name != @params[:company]}
    end

    @customers = what_the_sort!
    render json: { customers: @customers, params: @params }
  end

  private

  def customer_params
    params.permit(:name, :company, :sort_by)
  end

  def what_the_sort!
    # NOTE: There is no fall through case here as the default is defined above.
    case @params[:sort_by]
    when 'first_name_ascn'
      return @customers.sort_by {|cust| cust.first_name.downcase}
    when 'first_name_desc'
      return @customers.sort_by {|cust| cust.first_name.downcase}.reverse
    when 'last_name_ascn'
      return @customers.sort_by {|cust| cust.last_name.downcase}
    when 'last_name_desc'
      return @customers.sort_by {|cust| cust.last_name.downcase}.reverse
    when 'company_name_ascn'
      return @customers.sort_by {|cust| cust.company.name.downcase}
    when 'company_name_desc'
      return @customers.sort_by {|cust| cust.company.name.downcase}.reverse
    end
  end

end
