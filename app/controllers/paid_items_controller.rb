class PaidItemsController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :correct_user2, only: [:index, :new]
  before_action :set_paid_item, only: [:edit, :update, :destroy]
  before_action :set_travel, only: [:index, :new, :create]
  
  def index
    @paid_items = @travel.paid_items
  end

  def new
    @paid_item = PaidItem.new
  end

  def create
    @paid_item = @travel.paid_items.build(paid_item_params)
    
    if @paid_item.save
      flash[:success] = '項目を追加しました。'
      redirect_to paid_items_path
    else
      flash.now[:danger] = '項目の追加に失敗しました。'
      render :new
    end
  end

  def edit
    @travel = @paid_item.travel
  end
  
  def update
    @travel = @paid_item.travel
    
    if @paid_item.update(paid_item_params)
      flash[:success] = '項目を更新しました。'
      redirect_to paid_items_path(@paid_item.travel)
    else
      flash.now[:danger] = '項目の更新に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @paid_item.destroy
    flash[:success] = '項目を削除しました。'
    redirect_back(fallback_location: paid_items_path)
  end
  
  private
  
  def paid_item_params
    params.require(:paid_item).permit(:name, :cost)
  end
    
  def set_paid_item
    @paid_item = PaidItem.find(params[:id])
  end
  
  def set_travel
    @travel = Travel.find(params[:id])
  end
  
  def correct_user
    @paid_item = PaidItem.find(params[:id])
    unless @paid_item.travel.user == @current_user
      redirect_to travels_path
    end
  end
  
  def correct_user2
    @travel = Travel.find(params[:id])
    unless @travel.user == @current_user
      redirect_to travels_path
    end
  end
end
  