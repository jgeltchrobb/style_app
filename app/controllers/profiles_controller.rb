class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
    @offer = Offer.all.where(:user_id => @profile.user_id)
  end

  def stylists
    @profiles = Profile.all
    @user_loc = [current_user.profile.location.latitude,current_user.profile.location.longitude]
    filter_params.each do |key,value|
      @profiles = @profiles.public_send(key, value) if value.present?
    end
  end

  def scrubs
    @profiles = Profile.all
    @user_loc = [current_user.profile.location.latitude,current_user.profile.location.longitude]    
    filter_params.each do |key,value|
      @profiles = @profiles.public_send(key, value) if value.present?
    end
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
    @profile.locations.build
  end

  # GET /profiles/1/edit
  def edit
    @location = Location.find_by(current_user.profile.location_id)
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.build_location

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update

    # @location = Location.new
    # @profile.location_id = @location.id
    # @profile.location.suburb = params[:suburb]
    # @profile.location.save
    # @profile.location.suburb = params[:suburb]

    respond_to do |format|
      if @profile.update(profile_params)
        assign_user_role
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.where(:user_id => current_user.id).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:username, :bio, :profile_pic, :rating, :user_id, :user_role, :has_offers, location_attributes: [:suburb, :postcode, :state, :country])
    end

    def filter_params
      params.slice(:username, :bio, :suburb, :postcode, :state, :country)
    end

    def is_admin
      current_user.has_role?(:admin)
    end

    def assign_user_role
      if @profile.user_role == "stylist"
        current_user.remove_role(:scrub)
        current_user.add_role(:stylist)
      elsif @profile.user_role == "scrub"
        current_user.remove_role(:stylist)        
        current_user.add_role(:scrub)
      end
    end

end
