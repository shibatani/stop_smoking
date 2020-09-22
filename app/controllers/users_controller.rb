class UsersController < ApplicationController
  before_action :exists_user, only: [:show]
  before_action :correct_user, only: [:edit, :update]
  before_action :authenticate_user!, except: [:index, :search]

  def index
    @users = User.all.order('created_at').page(params[:page]).per(MAX_VIEW)
    @last_running_days = 0 
    @last_rank_number = 0  
    @rank_number = 0 
  end

  def show
    @user = User.find(params[:id])
    continue_days = @user.continue_days
    frequency = @user.frequency(continue_days)
    @saved_money = @user.saved_money(frequency)
    @cigarettes = @user.cigarettes(frequency)
    @lifespan = @user.lifespan(@cigarettes)

    @posts = @user.posts.includes(:favorites)
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

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to root_path, alert: "別のユーザのページに遷移できません。"
    end
  end

  def exists_user
    unless User.exists?(params[:id])
    flash.now[:alert] = "ユーザーが存在しません。"
    render template: "tops/index"
    end
  end
end
