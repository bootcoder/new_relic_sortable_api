class CustomersController < ApplicationController

  def index
    # Start off with All Customers. Widdle this down as we progress.
    @customers = Customer.includes(:company).all
    # Gather inputs and assign sensible defaults if needed.
    @companies = Company.all.pluck(:name)
    @req_params = {sort_by: customer_params[:sort_by] || 'last_name_ascn',
                   name:    customer_params[:name]    || '',
                   company: customer_params[:company] || 'All Companies'}

    # NOTE: The following helpers consume instance vars so they are decidedly non 'functional'
    # I think this is cleaner but am fine coding it up either way, just saying. :-)

    # Search customer set with given params
    @customers = search_customers
    # Apply sort to customers post search
    @customers = sort_customers
    # Set a limit of 50 customers
    @customers = @customers[0...50]

    # Render params and remaining customer set as JSON
    render json: {
      params: @req_params,
      customers: ActiveModelSerializers::SerializableResource.new(@customers).as_json,
      companies: @companies }
  end

  private

  def customer_params
    params.permit(:name, :company, :sort_by)
  end

  def search_customers
    if @req_params[:name] && @req_params[:name] != ''
      @customers = Customer.includes(:company).by_first_or_last_name(@req_params[:name])
    end

    # NOTE: Started covering edge cases here but decided on a whitelist approach
    # This accomplishes the same result while being much more extensible than.
    # if @req_params[:company] && @req_params[:company] != 'all' && @req_params[:company] != ''
    if Company.all.pluck(:name).include? @req_params[:company]
      # Rejecting over pre-established @customers ensures accurate
      # company search in conjunction with a name search. This pattern grows easily.
      @customers = @customers.reject { |cust| cust.company.name != @req_params[:company] }
    end
    @customers
  end

  def sort_customers
    # NOTE: There is no fall through case here as the default is defined above.
    case @req_params[:sort_by]
    when 'first_name_ascn'
      return @customers.sort_by { |cust| cust.first_name.downcase }
    when 'last_name_ascn'
      return @customers.sort_by { |cust| cust.last_name.downcase }
    when 'company_name_ascn'
      return @customers.sort_by { |cust| cust.company.name.downcase }
    when 'first_name_desc'
      return @customers.sort_by { |cust| cust.first_name.downcase}.reverse
    when 'last_name_desc'
      return @customers.sort_by { |cust| cust.last_name.downcase}.reverse
    when 'company_name_desc'
      return @customers.sort_by { |cust| cust.company.name.downcase}.reverse
    end
  end

end
