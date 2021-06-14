class BlogsController < ApplicationController
    before_action :authenticate_user!, {only: [:new, :edit, :update, :destroy]}

    def new
        @blog = Blog.new
    end

    def create
        @blog = Blog.new(blog_params)
        @blog.user_id = current_user.id
        if @blog.save
         redirect_to blogs_path
        else
         render :new
        end
    end

    def index
        @blogs = Blog.all
    end

    def show
        @blog = Blog.find(params[:id])
        @post_comment = PostComment.new
    end

    def edit
        @blog = Blog.find(params[:id])
        unless @blog.user == current_user
            redirect_to blog_path(@blog.id)
        end
    end

    def update
        @blog = Blog.find(params[:id])
        if @blog.update(blog_params)
         redirect_to blog_path(@blog.id)
        else
         render :edit
        end
    end

    def destroy
        @blog = Blog.find(params[:id])
        @blog.destroy
        redirect_to user_path(@blog.user_id)
    end

    private

    def blog_params
        params.require(:blog).permit(:title,:body,:image)
    end
end
