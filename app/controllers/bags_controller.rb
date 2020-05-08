class BagsController < ApplicationController
  def index
    @bags = current_user.bags
  end

  def show
    @bag = Bag.find(params[:id])

    #Attempting to order discs based on position
    # slots = @bag.slots
    # slots.sort_by { |obj| obj.position}
    # @discs = slots.disc
  end

  def new
    @bag = Bag.new
  end

  def edit
    @bag = Bag.find(params[:id])
    #Number of slots left
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
    @bag = Bag.find(params[:id])

    if @bag.update_attributes(bag_params)
      redirect_to action: "show", id: @bag
    else
      render action: "edit"
    end
  end

  def destroy
    @bag = Bag.find(params[:id])
    @bag.destroy
    redirect_to action: "index"
  end

  def bag_params
    params.require(:bag).permit(:name, :capacity, :user_id, slots_attributes: [:disc_id, :id, :position])
  end

end
