class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :profile
  has_many :deals
end
