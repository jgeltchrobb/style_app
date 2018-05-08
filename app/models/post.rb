class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  resourcify
  mount_uploader :image, PostImageUploader
  after_create :set_owner_role

  scope(:title, -> (title) { where("LOWER(title) like ?", "%#{title.downcase}%")})
  scope(:content, -> (content) { where("LOWER(content) like ?", "%#{content.downcase}%")})
  scope(:owner_role, -> (owner_role) { where("LOWER(owner_role) like ?", "%#{owner_role.downcase}%")})  

  def set_owner_role
    if self.user.has_role?(:stylist)
      self.owner_role = "stylist"
    elsif self.user.has_role?(:scrub)
      self.owner_role = "scrub"
    else
      self.owner_role = "none"
    end
    self.save
  end
end
