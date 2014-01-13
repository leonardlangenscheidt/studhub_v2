class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    unless current_user && current_user.admin==true
      flash[:notice] = "Please don't mess around with our backend!"
      redirect_to root_url
    end
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    unless current_user && current_user.admin==true
      flash[:notice] = "Please don't mess around with our backend!"
      redirect_to root_url
    end
  end

  # GET /comments/new
  def new
    if current_user
      @email = current_user.email
    end
    @comment = Comment.new
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to root_path, notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:email, :text)
    end
end