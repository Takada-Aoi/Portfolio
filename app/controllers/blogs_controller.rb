class BlogsController < ApplicationController
    before_action :authenticate_user!, {only: [:new, :edit, :update, :destroy]}
    before_action :set_q, only: [:index, :search]

    def new
        @blog = Blog.new
    end

    def create
        @blog = Blog.new(blog_params)
        @blog.user_id = current_user.id
        tag_list = params[:blog][:tag_ids].split(',')
        if @blog.save
           @blog.save_tags(tag_list)
           flash[:success] = '投稿しました!'
           redirect_to blogs_path
        else
           render :new
        end
    end

    def index
        @blogs = Blog.page(params[:page]).reverse_order.order(created_at: :desc)
    end

    def show
        @blog = Blog.find(params[:id])
        @post_comment = PostComment.new
    end

    def edit
        @blog = Blog.find(params[:id])
        @tag_list =@blog.tags.pluck(:name).join(",")
        unless @blog.user == current_user
            redirect_to blog_path(@blog.id)
        end
    end

    def update
        @blog = Blog.find(params[:id])
        tag_list = params[:blog][:tag_ids].split(',')
        if @blog.update(blog_params)
           @blog.save_tags(tag_list)
           flash[:success] = '投稿を編集しました‼'
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

    def search
        @results = @q.result
    end

    private

    def blog_params
        params.require(:blog).permit(:title,:body,:image,:category_id)
    end

    def set_q
        @q = Blog.ransack(params[:q])
    end
end
