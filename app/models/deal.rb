class Deal < ApplicationRecord
  belongs_to :profile
  belongs_to :user
  belongs_to :offer
end
