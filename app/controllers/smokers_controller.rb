class SmokersController < ApplicationController
  before_action :authenticate_user!

  def index
    @smokers = Smoker.all
  end

  def new
    @smoker = Smoker.new
  end

  def create
    Smoker.create(smoker_params)
  end

  def edit
    @smoker = Smoker.find(params[:id])
  end

  def update
    smoker = Smoker.find(params[:id])
    smoker.update(smoker_params)
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
    params.require(:smoker).permit(:name,:word,:image)
  end
end
