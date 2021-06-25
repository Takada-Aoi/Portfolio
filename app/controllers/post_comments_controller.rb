class PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    blog = Blog.find(params[:blog_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.blog_id = blog.id
    if comment.save
       redirect_back(fallback_location: root_path)
    else
       render ''
    end
  end

  def destroy
    PostComment.find_by(id:params[:id],blog_id:params[:blog_id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
