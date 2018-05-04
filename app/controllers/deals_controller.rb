class DealsController < ApplicationController
  before_action :set_deal, only: [:show, :edit, :update, :destroy]

  # GET /deals
  # GET /deals.json
  def index
    if current_user.has_role?(:stylist)
      @deals = Deal.all.where(:profile.id => current_user.id)
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
    @deal.buyer = current_user.id
    @deal = deal
    # Sends email to stylist
    DealNotifierMailer.send_deal_email(@deal, @deal.buyer).deliver
  end

  # GET /deals/new
  def new
    @deal = Deal.new(deal_params)
    # @deal = @deal.update(deal_params)
    # render plain: params
  end

  # GET /deals/1/edit
  def edit
  end

  # POST /deals
  # POST /deals.json
  def create
    @deal = Deal.new(deal_params)
    request_deal(@deal)
    
    respond_to do |format|
      if @deal.save
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
    @buyer = User.all.find_by(:id => @deal.buyer)
    if @deal.stylist_agree == "true"
      # Sends email to buyer
      AcceptedNotifierMailer.send_accepted_email(@deal, @buyer).deliver
    end
      
    respond_to do |format|
      if @deal.update(deal_params)
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
end
