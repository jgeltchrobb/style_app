class DealsController < ApplicationController
  before_action :set_deal, only: [:show, :edit, :update, :destroy]

  # GET /deals
  # GET /deals.json
  def index
    no_deals and return unless Deal.all.find_by(buyer: current_user.id).present?
    if current_user.has_role?(:stylist)
      @deals = Deal.all.where(profile_id: current_user.id)
    elsif current_user.has_role?(:scrub)
      @deals = Deal.all.where(:buyer => current_user.id)
    end
    
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
    # render plain: @deal.inspect
  end

  def request_deal(deal)
    @user = current_user
    @deal = deal
    # Sends email to stylist
    # begin
    # DealNotifierMailer.send_deal_email(@deal, @user).deliver
    # flash[:success] = "Deal created!"
    # rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
    #   flash[:success] = "Deal created, however problems sending notification email to stylist"
    # end
  end

  # GET /deals/new
  def new
    @deal = Deal.new(deal_params)
    # @deal = @deal.update(deal_params)
    # render plain: params
  end

  # GET /deals/1/edit
  def edit
    not_authorised and return unless current_user.has_role?(:admin)
  end

  # POST /deals
  # POST /deals.json
  def create
    
    @deal = Deal.new(deal_params)
    
    respond_to do |format|
      if @deal.save
        finish_profile and return unless current_user.completed_profile?   
        request_deal(@deal)
        format.html { redirect_to @deal, notice: 'Deal was successfully created.' }
        format.json { render :show, status: :created, location: @deal }
      else
        format.html { render :new }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deals/1
  # PATCH/PUT /deals/1.json
  def update
    
    respond_to do |format|
      if @deal.update(deal_params)
        if @deal.stylist_agree == true && @deal.scrub_agree != true
          @buyer = @deal.user
          # Sends email to buyer
          # AcceptedNotifierMailer.send_accepted_email(@deal, @buyer).deliver
        end
        format.html { redirect_to @deal, notice: 'Deal was successfully updated.' }
        format.json { render :show, status: :ok, location: @deal }
      else
        format.html { render :edit }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    not_authorised and return unless current_user.has_role?(:admin)

    @deal.destroy
    respond_to do |format|
      format.html { redirect_to deals_url, notice: 'Deal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deal_params
      params.require(:deal).permit(:id, :stylist_agree, :scrub_agree, :paid, :profile_id, :user_id, :offer_id, :buyer)
    end

    def finish_profile
      flash[:notice] = "You need to complete your profile before you can request a deal"
      redirect_to profile_path(@deal.user.id)
    end

    def not_authorised
      flash[:notice] = "You are not authorised!"
      redirect_to deals_path
    end

    def no_deals
      flash[:notice] = "You have no deals"
      redirect_to posts_path
    end

end
