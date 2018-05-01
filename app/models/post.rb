class Post < ApplicationRecord
  belongs_to :user
  resourcify
  mount_uploader :image, PostImageUploader
end
