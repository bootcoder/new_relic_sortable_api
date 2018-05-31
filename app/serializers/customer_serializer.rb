class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :company_name

  def company_name
    self.object.company.name
  end

end
