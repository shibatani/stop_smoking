class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search]

  def index
    @max_view = 50
    @users = User.all.order('created_at').page(params[:page]).per(@max_view)
  end

  def show
    @user = User.find(params[:id])

    continue_days = @user.continue_days
    frequency = @user.frequency(continue_days)
    @saved_money = @user.saved_money(frequency)
    @cigarettes = @user.cigarettes(frequency)
    @lifespan = @user.lifespan(@cigarettes)

    @posts = @user.posts
    @favorite_posts = @user.favorite_posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.update(user_params)
      redirect_to user_path(current_user.id), notice: "更新しました。"
    else
      flash.now[:alert] = "入力に不備があります。"
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end

  def search
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    else
      @users = User.all
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:word,:image,:days,:boxes)
  end
end
