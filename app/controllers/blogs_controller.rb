class BlogsController < ApplicationController
    before_action :authenticate_user!, {only: [:new, :edit, :update, :destroy]}
    
    def new
        @blog = Blog.new
    end
    
    def create
        @blog = Blog.new(blog_params)
        @blog.user_id = current_user.id
        if @blog.save
        redirect_to user_path(current_user.id)
        else
        render :new
        end
    end    
    
    private
    
    def blog_params
        params.require(:blog).permit(:title,:body,:image)
    end    
end
