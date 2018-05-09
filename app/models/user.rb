class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :offers
  has_many :deals
  has_many :comments
  has_one :profile

  after_create :set_role
  after_create :add_profile
  # after_create :signup_email
 
  def set_role
    add_role :author
  end

  def add_profile
    x = Profile.create(user_id: self.id)
    Location.create(profile_id: x.id)
  end

  # def signup_email
  #     begin
  #     UserSignupMailer.send_signup_email(self).deliver
  #     flash[:success] = "Account created"
  #     rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
  #       flash[:success] = "Account created but an issue sending email"
  #     end
  #     # redirect_to "/"
  # end

  def can_create?(post)
    self.has_role?(:admin) || self.has_role?(:author)
  end
 
  def can_update?(post)
    self.has_role?(:admin) || (self.has_role?(:author) && post.user_id == self.id)
  end
 
  def can_delete?(post)
    self.has_role?(:admin) || self.has_role?(:moderator) || (self.has_role?(:author) && post.user_id == self.id)
  end

  def completed_profile?
    self.profile.username.present? && self.profile.bio.present? && self.profile.profile_pic.present? && self.profile.user_role.present?
  end
end
