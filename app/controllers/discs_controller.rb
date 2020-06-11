class DiscsController < ApplicationController
  before_action :set_disc, only: [:show, :edit, :update, :destroy]
  before_action :require_disc_owner!, only: [:edit, :update, :destroy]

  def index
    @q = current_user.discs.ransack(params[:q])
    @discs = @q.result(distinct: true)
  end

  def show
  end

  def new
    @disc = Disc.new
  end

  def edit
  end

  def create
    @disc = current_user.discs.new(disc_params)

    if @disc.save
      redirect_to discs_path
    else
      flash[:errors] = @disc.errors.full_messages
      render action: "new"
    end
  end

  def update
    if @disc.update(disc_params)
      redirect_to action: "show", id: @disc
    else
      render action: "edit"
    end
  end

  def destroy
    @disc.destroy
    redirect_to action: "index"
  end

  private

  def disc_params
    params.require(:disc).permit(:model, :brand, :color, :plastic_type, :weight, :condition, :speed, :glide, :turn, :fade, :description, :nickname, :user_id, :picture)
  end

  def set_disc
    @disc = Disc.find(params[:id])
  end

  def require_disc_owner!
    if current_user != @disc.user
      redirect_to({action: "show"}, alert: "You do not have permission to access this page!")
    end
  end
end
