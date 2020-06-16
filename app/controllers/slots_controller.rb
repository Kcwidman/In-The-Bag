class SlotsController < ApplicationController
  before_action :authenticate_user!
  def edit
    @bag = Bag.find(params[:bag_id])
    @existing_slots = @bag.slots.to_a
    @discs = current_user.discs.where.not(id: @bag.discs.pluck(:id)) # all the user's discs that aren't in a bag
    @new_slots = @discs.map { |d| @bag.slots.build(disc: d) }
  end

  def update
    @bag = Bag.find(params[:bag_id])
    if @bag.update(slot_params)
      redirect_to edit_bag_path(@bag)
    else
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
    params.require(:bag).permit(slots_attributes: [:disc_id, :id, :position, :_destroy])
  end
end
