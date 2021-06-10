class PostCommentsController < ApplicationController
  
  def create
    blog = Blog.find(params[:blog_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.blog_id = blog.id
    comment.save
    redirect_to blog_path(blog.id)
  end
  
  def destroy
    PostComment.find_by(id:params[:id],blog_id:params[:blog_id]).destroy
    redirect_to blog_path(params[:blog_id])
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end 
  
end
