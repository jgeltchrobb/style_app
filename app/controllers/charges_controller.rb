class ChargesController < ApplicationController
  before_action :set_deal

  def new
    
    redirect_to deal_path(@deal)
  end
  
  def create
  
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
  
    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'aud'
    )
  
    DealReceiptMailer.send_receipt_email(@deal).deliver
    DealReceiptMailer.notify_stylist_of_payment(@deal).deliver
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to deal_path(@deal)
  end

  private

  def set_deal
    @deal = Deal.find(params[:deal_id])
    @amount = (@deal.offer.price * 100).to_i # since database has prices stored as decimals but Stripe needs cents to do it's thing
  end

end
