class SmokersController < ApplicationController
  before_action :authenticate_user!

  def index
    @smokers = Smoker.all
  end

  def new
    @smoker = Smoker.new
  end

  def create
    @smoker = Smoker.create(smoker_params)
    if @smoker.save
      redirect_to smokers_path, notice: "新規登録しました。"
    else
      flash.now[:alert] = "入力に不備があります。"
      render :new
    end
  end

  def edit
    @smoker = Smoker.find(params[:id])
  end

  def update
    @smoker = Smoker.find(params[:id])
    @smoker.update(smoker_params)
    if @smoker.update(smoker_params)
      redirect_to smokers_path, notice: "更新しました。"
    else
      flash.now[:alert] = "入力に不備があります。"
      render :edit
    end

  end

  def destroy
    smoker = Smoker.find(params[:id])
    smoker.destroy
    redirect_to smokers_path
  end

  def show
    @smoker = Smoker.find(params[:id])
  end

  private
  def smoker_params

    params.require(:smoker).permit(:name,:word,:days,:image)
  end
end
