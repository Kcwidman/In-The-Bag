class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  before_action :require_offer_owner!, only: [:edit, :update, :destroy]
  before_action :check_disc_attributes, only: [:new]

  def index
    @q = Offer.where(public: true).ransack(params[:q])
    @offers = @q.result(distinct: true)
  end

  def show
    @disc = @offer.disc
  end

  def new
    @offer = Offer.new
    @offer.disc_id = params[:disc_id]
  end

  def create
    @offer = current_user.offers.new(offer_params)
    @offer.public = true

    @offer.save
    redirect_to my_offers_offers_path
  end

  def update
    if @offer.update(public: params[:public])
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

  def select
    @q = current_user.discs.ransack(params[:q])
    @discs = @q.result(distinct: true)
  end

  private

  def offer_params
    params.require(:offer).permit(:description, :public, :disc_id, :disc)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def require_offer_owner!
    if current_user != @offer.user
      redirect_to({action: "show"}, alert: "You do not have permission to access this page!")
    end
  end

  def check_disc_attributes
    @disc = Disc.find(params[:disc_id])
    @notice = ""
    @picture = "picture"
    if @disc.picture.blank?
      @notice = @notice + "picture, "
    end
    if @disc.model.blank?
      @notice = @notice + "mold, "
    end
    if @disc.plastic_type.blank?
      @notice = @notice + "plastic type, "
    end
    if @disc.brand.blank?
      @notice = @notice + "brand, "
    end
    if flight_numbers_present?(@disc)
      @notice = @notice + "flight numbers, "
    end
    if @disc.weight.blank?
      @notice = @notice + "weight, "
    end
    if @disc.color.blank?
      @notice = @notice + "color, "
    end
    if @disc.condition.blank?
      @notice = @notice + "condition, "
    end
    if @notice.present?
      @notice.delete_suffix!(", ")
      redirect_to({action: "select"}, alert: "Please update your disc with the following information before you trade it: #{@notice}")
    end
  end

  def flight_numbers_present?(disc)
    disc.speed.blank? || disc.glide.blank? || disc.turn.blank? || disc.fade.blank?
  end
end
