class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :profile_pic, ProfileImageUploader
  
  has_many :deals
  has_many :offers
  has_one :location
  accepts_nested_attributes_for :location

  after_create :add_location

  def add_location
    location = Location.create(profile_id: self.id)
  end

end
