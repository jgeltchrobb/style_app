class AcceptedNotifierMailer < ApplicationMailer
  default :from => 'noreply@foo.com'
 
  def send_accepted_email(deal, buyer)
    @deal = deal
    @buyer = buyer
    mail(:to => @buyer.email, :subject => 'Your request has been accepted')
  end
end
