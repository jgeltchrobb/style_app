class DealNotifierMailer < ApplicationMailer
  default :from => 'noreply@foo.com'
 
  def send_deal_email(deal, user)
    @deal = deal
    @user = User.find_by(:id => user.id)
    mail(:to => @deal.profile.user.email, :subject => 'New Deal Requested')
  end
end
