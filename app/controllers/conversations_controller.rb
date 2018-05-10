class ConversationsController < ApplicationController

  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def new
    # @profile = Profile.find(params[:id])
    @user = User.find(params[:user_id])
    # render plain: @user.inspect 
    # @recipient = User.find_by(id: params[:user_id])
  end

  def create
    # render plain: params.inspect
    
    recipient = User.find(params[:user_id])
    receipt = current_user.send_message(recipient, params[:body], params[:subject])
    redirect_to conversation_path(receipt.conversation)
  end

end