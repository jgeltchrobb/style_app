class ReviewsController < ApplicationController

  def index
    # render plain: params.inspect
    @reviews = Review.all
  end

  def new
    # render plain: params.inspect
    @profile = Profile.find(params[:profile_id])
    @deal = Deal.find(params[:deal_id])
    @review = Review.new
  end
  def show
    redirect_to profile_path(params[:id])
  end

  def create
    @review = Review.new(review_params) 
    @review.profile_id = params[:profile_id]
    @review.deal_id = params[:deal_id]
    
    # render plain: @review.inspect
    respond_to do |format|
      if @review.save
        format.html { redirect_to profile_path(@review.profile_id), notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, review: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :deal_id, :profile_id)
  end

end
