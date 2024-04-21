class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "success"
    else
      flash[:alert] = "failed"
    end
    redirect_back(fallback_location: root_url)
  end
  
  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy if @comment
    flash[:notice] = "success"
    redirect_back(fallback_location: root_url)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:book_id, :body)
  end
end
