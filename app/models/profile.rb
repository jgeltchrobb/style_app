class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :profile_pic, ProfileImageUploader
  
  has_many :deals
  has_many :offers
  has_one :location, :dependent => :destroy
  accepts_nested_attributes_for :location


  scope(:username, -> (username) { where("LOWER(username) like ?", "%#{username.downcase}%")})
  scope(:bio, -> (bio) { where("LOWER(bio) like ?", "%#{bio.downcase}%")})
  # scope(:rating, -> (rating) { where(rating: rating)}) 

  scope(:suburb, -> (suburb) { joins(:location).where("LOWER(suburb) like ?", "%#{suburb.downcase}%")})
  scope(:postcode, -> (postcode) { joins(:location).where("LOWER(postcode) like ?", "%#{postcode.downcase}%")})
  scope(:state, -> (state) { joins(:location).where("LOWER(state) like ?", "%#{state.downcase}%")})
  scope(:country, -> (country) { joins(:location).where("LOWER(country) like ?", "%#{country.downcase}%")})
  
end
