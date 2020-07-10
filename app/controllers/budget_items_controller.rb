class BudgetItemsController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :set_budget_item, only: [:edit, :update, :destroy]
  
  def index
    @travel = Travel.find(params[:id])
    @budget_items = @travel.budget_items
  end

  def new
    @budget_item = BudgetItem.new
    @travel = Travel.find(params[:id])
  end

  def create
    travel = Travel.find(params[:id])
    @budget_item = travel.budget_items.build(budget_item_params)
    
    if @budget_item.save
      flash[:success] = '項目を追加しました。'
      redirect_to budget_items_path
    else
      flash.now[:danger] = '項目の追加に失敗しました。'
      render :new
    end
  end

  def edit
  end
  
  def update
    
    if @budget_item.update(budget_item_params)
      flash[:success] = '項目を更新しました。'
      redirect_to budget_items_path(@budget_item.travel)
    else
      flash.now[:danger] = '項目の更新に失敗しました。'
      render :new
    end
  end
  
  def destroy
    @budget_item.destroy
    flash[:success] = '項目を削除しました。'
    redirect_back(fallback_location: budget_items_path)
  end
  
  private
  
  def budget_item_params
    params.require(:budget_item).permit(:name, :cost)
  end
  
  def set_budget_item
    @budget_item = BudgetItem.find(params[:id])
  end
end
