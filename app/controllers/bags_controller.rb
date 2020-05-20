class BagsController < ApplicationController
  before_action :set_bag, only: [:show, :edit, :update, :destroy]

  def set_bag
    @bag = Bag.find(params[:id])
  end

  def index
    @bags = current_user.bags
  end

  def show
    @slots=@bag.slots.order ("position ASC NULLS LAST")
  end

  def new
    @bag = Bag.new
  end

  def edit
    #Number of slots left, build slots
    ( @bag.capacity - Slot.where("bag_id = ?", @bag.id).count ).times { @bag.slots.build }
  end

  def create
    @bag = current_user.bags.new(bag_params)

    if @bag.save
      #For "Add some discs" button
      if params['bag_edit']
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
    if @bag.update_attributes(bag_params)
      redirect_to action: "show", id: @bag
    else
      render action: "edit"
    end
  end

  def destroy
    @bag.slots.each do |slot|
      slot.destroy
    end

    @bag.destroy
    redirect_to action: "index"
  end

  def bag_params
    params.require(:bag).permit(:name, :capacity, :user_id, slots_attributes: [:disc_id, :id, :position])
  end

end
