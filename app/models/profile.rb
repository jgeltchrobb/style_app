class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :profile_pic, ProfileImageUploader

  has_many :deals
  has_many :offers
end
