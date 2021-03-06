class BagsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_bag, only: [:show, :edit, :update, :destroy]
  before_action :require_bag_owner!, only: [:edit, :update, :destroy]

  def index
    @bags = current_user.bags
  end

  def show
    @slots = @bag.slots.order("position ASC NULLS LAST")
  end

  def new
    @bag = Bag.new
  end

  def edit
  end

  def create
    @bag = current_user.bags.new(bag_params)

    if @bag.save
      # For "Add some discs" button
      if params["bag_edit"]
        redirect_to edit_bag_path(@bag)
      else
        redirect_to bags_path
      end
    else
      flash[:errors] = @bag.errors.full_messages
      render action: "new"
    end
  end

  def update
    if @bag.update(bag_params)
      redirect_to action: "show", id: @bag
    else
      flash[:errors] = @bag.errors.full_messages
      render action: "edit"
    end
  end

  def destroy
    @bag.destroy
    redirect_to action: "index"
  end

  private

  def bag_params
    params.require(:bag).permit(:name, slots_attributes: [:disc_id, :id, :position])
  end

  def set_bag
    @bag = Bag.find(params[:id])
  end

  def require_bag_owner!
    if current_user != @bag.user
      redirect_to({action: "show"}, alert: "You do not have permission to access this page!")
    end
  end
end
