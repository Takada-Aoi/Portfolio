class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs
    @favorite_blogs = @user.favorite_blogs
  end

  def index
    @users = User.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name,:nickname,:profile,:profile_image)
  end

end
