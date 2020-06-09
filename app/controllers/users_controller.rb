class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user_owner!, only: [:edit, :update, :destroy]

  def index
    @featured = User.first(5)
    @most_followed = User.first(5)
    @following = User.first(5)
    @q_empty = (params[:q]&.permit!&.to_h || {}).all? { |key, value| value.blank? }
    @q = User.all.ransack(params[:q])
    @results = @q.result
  end

  def show
    @bags = @user.bags
    @discs = @user.discs
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
    if @user.update(user_params)
      redirect_to action: "index"
    else
      render action: "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to action: "index"
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :PDGA_num, :bio)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_user_owner!
    if current_user != @user
      redirect_to({action: "show"}, alert: "You do not have permission to access this page!")
    end
  end
end
