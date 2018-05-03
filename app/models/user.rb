class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :offers
  has_many :deals
  has_one :profile

  after_create :set_role
  after_create :add_profile
 
  def set_role
    add_role :author
  end

  def add_profile
    Profile.create(user_id: self.id)
    profile = Profile.where(:user_id => self.id)
    self.profile_id = profile.first.id 
  end

  def can_create?(post)
    self.has_role?(:admin) || self.has_role?(:author)
  end
 
  def can_update?(post)
    self.has_role?(:admin) || (self.has_role?(:author) && post.user_id == self.id)
  end
 
  def can_delete?(post)
    self.has_role?(:admin) || self.has_role?(:moderator) || (self.has_role?(:author) && post.user_id == self.id)
  end
end
