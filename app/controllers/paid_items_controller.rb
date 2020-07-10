class PaidItemsController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :set_paid_item, only: [:edit, :update, :destroy]
  
  def index
    @travel = Travel.find(params[:id])
    @paid_items = @travel.paid_items
  end

  def new
    @paid_item = PaidItem.new
    @travel = Travel.find(params[:id])
  end

  def create
    travel = Travel.find(params[:id])
    @paid_item = travel.paid_items.build(paid_item_params)
    
    if @paid_item.save
      flash[:success] = '項目を追加しました。'
      redirect_to paid_items_path
    else
      flash.now[:danger] = '項目の追加に失敗しました。'
      render :new
    end
  end

  def edit
  end
  
  def update
    
    if @paid_item.update(paid_item_params)
      flash[:success] = '項目を更新しました。'
      redirect_to paid_items_path(@paid_item.travel)
    else
      flash.now[:danger] = '項目の更新に失敗しました。'
      render :new
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
  
end
  