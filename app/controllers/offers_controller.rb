class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  before_action :require_offer_owner!, only: [:edit, :update, :destroy]

  def index
    @q = Offer.where(public: true).ransack(params[:q])
    @offers = @q.result(distinct: true)
  end

  def show
    @disc = @offer.disc
  end

  def new
    @offer = Offer.new
  end

  def edit
  end

  def create
    @offer = current_user.offers.new(offer_params)

    if @offer.save
      redirect_to offers_path
    else
      flash[:errors] = @offer.errors.full_messages
      render action: "new"
    end
  end

  def update
    if @offer.update(offer_params)
      redirect_to action: "show", id: @offer
    else
      render action: "edit"
    end
  end

  def destroy
    @offer.destroy
    redirect_to action: "index"
  end

  def my_offers
    @q = current_user.offers.ransack(params[:q])
    @offers = @q.result(distinct: true)
    render action: "index"
  end

  private

  def offer_params
    params.require(:offer).permit(:description, :public, :disc_id)
  end
  
  def set_offer
    @offer = Offer.find(params[:id])
  end

  def require_offer_owner!
    if current_user != @offer.user
      redirect_to({action: "show"}, alert: "You do not have permission to access this page!" )
    end
  end
  
end