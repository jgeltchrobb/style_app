class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :profile
  has_many :deals

  # scope(:description, -> (description) { where("LOWER(description) like ?", "%#{description.downcase}%")})
  # scope(:price, -> (price) { where price: price })

end
