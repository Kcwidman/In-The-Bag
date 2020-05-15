class UsersController < ApplicationController
  def index
    @featured = User.first(5)
    @most_followed = User.first(5)
    @following = User.first(5)
    @q = User.all.ransack(params[:q])
    @results = @q.result
  end

  def show
    @user = User.find(params[:id])
    @bags = @user.bags
    @discs = @user.discs
  end

  def new
  end

  def edit
    @user = current_user
  end

  def create
  end

  def update
    @user = current_user

    if @user.update_attributes(user_params)
      redirect_to action: "edit", id: @user
    else
      render action: "edit"
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to action: "index"
  end

  def user_params
    params.require(:user).permit(:name, :username, :PDGA_num, :bio)
  end

end
