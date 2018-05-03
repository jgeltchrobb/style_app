class DealNotifierMailer < ApplicationMailer
  default :from => 'noreply@foo.com'
 
  def send_deal_email(deal, user)
    @deal = deal
    @user = User.find_by(:id => user)
    mail(:to => @deal.user.email, :subject => 'New Deal Requested')
  end
end
