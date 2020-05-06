class DiscsController < ApplicationController
  def index
    @discs = Disc.all
  end

  def show
    @disc = Disc.find(params[:id])
  end

  def new
    @disc = Disc.new
  end

  def edit
    @disc = Disc.find(params[:id])
  end

  def create
    @disc = Disc.new(disc_params)

      if @disc.save
        redirect_to discs_path
      else
        flash[:errors] = @disc.errors.full_messages
        render action: "new"
      end
  end

  def update
    @disc = Disc.find(params[:id])

    if @disc.update_attributes(disc_params)
      redirect_to action: "show", id: @disc
    else
      render action: "edit"
    end
  end

  def destroy
    @disc = Disc.find(params[:id])
    @disc.destroy
    redirect_to action: "index"
  end

  def disc_params
    params.require(:disc).permit(:model, :brand, :color, :plastic_type, :weight, :condition, :speed, :glide, :turn, :fade, :description, :nickname, :user_id)
  end

end
