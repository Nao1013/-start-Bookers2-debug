class PostCommentsController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.book_id = book
    if comment.save
     render :create
    end
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
    @post = Post.find(params[:post_id])
    render :create
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
