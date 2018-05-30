class Customer < ApplicationRecord
  belongs_to :company

  def self.by_first_or_last_name(name)
    where("LOWER(customers.first_name) LIKE ? OR LOWER(customers.last_name) LIKE ?",
    "%#{name.downcase}%", "%#{name.downcase}%")
  end
end
