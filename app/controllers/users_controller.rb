class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
  	@user = User.find(params[:id])
  	@books = @user.books.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
  	@user = current_user
  	if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
  	   redirect_to user_path(@user.id)
    else
      @user = current_user
      render action: :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
