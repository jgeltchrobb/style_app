class DealReceiptMailer < ApplicationMailer
  default :from => 'noreply@foo.com'
 
  def send_receipt_email(deal)
    @deal = deal
    mail(:to => @deal.user.email, :subject => 'Deal Paid')
  end

  def notify_stylist_of_payment(deal)
    @deal = deal
    mail(:to => @deal.profile.user.email, :subject => 'Deal Paid')
  end
end
