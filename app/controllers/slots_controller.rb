class SlotsController < ApplicationController
  def new
    @slot = Slot.new
    @bag = Bag.find(params[:bag_id])
    @discs = current_user.discs.where.not(id: @bag.discs.pluck(:id)) #all the user's discs that aren't in a bag
  end

  def create
    @bag = Bag.find(params[:bag_id])
    @slot = Slot.new(slot_params)
    @slot.bag = @bag
    @slot.position = @bag.discs.count

    if @slot.save
      redirect_to edit_bag_path(@bag)
    else
      flash[:errors] = @slot.errors.full_messages
      render action: "new"
    end
  end

  def destroy
    @slot = Slot.find(params[:id])
    @slot.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def slot_params
    params.require(:slot).permit(:bag_id, :disc_id, :position)
  end
end
