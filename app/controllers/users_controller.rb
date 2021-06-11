class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs
    @favorite_blogs = @user.favorite_blogs
  end

  def index
    @users = User.all
  end
  
  def follows
    user = User.find(params[:id])
    @users = user.followings
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.followers
  end 
  
end
