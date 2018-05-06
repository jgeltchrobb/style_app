class Location < ApplicationRecord
  belongs_to :profile
  geocoded_by :full_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  def full_address
    return "#{self.suburb}, #{state}, #{country}, #{postcode}"
  end

end
