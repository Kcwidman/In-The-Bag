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
    @offers = current_user.offers
  end

  def select
    @q = current_user.discs.ransack(params[:q])
    @discs = @q.result(distinct: true)
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
      redirect_to({action: "show"}, alert: "You do not have permission to access this page!")
    end
  end

  def check_disc_attributes
    @disc = Disc.find(params[:disc_id])
    attributes = []
    attributes << "picture" if @disc.picture.blank?
    attributes << "plastic type" if @disc.plastic_type.blank?
    attributes << "brand" if @disc.brand.blank?
    attributes << "flight numbers" if flight_numbers_present?(@disc)
    attributes << "weight" if @disc.weight.blank?
    attributes << "color" if @disc.color.blank?
    attributes << "condition" if @disc.condition.blank?
    attributes = attributes.join(", ").to_s
    if attributes.present?
      redirect_to({action: "select"}, alert: "Please update your disc with the following information before you trade it: #{attributes}")
    end
  end

  def flight_numbers_present?(disc)
    disc.speed.blank? || disc.glide.blank? || disc.turn.blank? || disc.fade.blank?
  end
end
