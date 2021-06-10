class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs
  end

  def index
    @users = User.all
  end
end
