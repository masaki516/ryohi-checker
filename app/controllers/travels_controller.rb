class TravelsController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]


  def index
    @travels = current_user.travels.order(id: :desc).page(params[:page]).per(4)
  end
  
  def new
    @travel = Travel.new
  end
  
  def create
    @travel = current_user.travels.build(travel_params)

    if @travel.save
      flash[:success] = '旅行を追加しました。'
      redirect_to root_path
    else
      flash.now[:danger] = '旅行の追加に失敗しました。'
      render :new
    end
  end

  def destroy
    @travel.destroy
    flash[:success] = '旅行を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def travel_params
    params.require(:travel).permit(:name)
  end
  
  def correct_user
    @travel = current_user.travels.find_by(id: params[:id])
    unless @travel
      redirect_to travels_url
    end
  end
end
