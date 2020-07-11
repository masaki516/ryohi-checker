class BudgetItemsController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :correct_user2, only: [:index, :new]
  before_action :set_budget_item, only: [:edit, :update, :destroy]
  before_action :set_travel, only: [:index, :new, :create]
  
  def index
    @budget_items = @travel.budget_items
  end

  def new
    @budget_item = BudgetItem.new
  end

  def create
    @budget_item = @travel.budget_items.build(budget_item_params)
    
    if @budget_item.save
      flash[:success] = '項目を追加しました。'
      redirect_to budget_items_path
    else
      flash.now[:danger] = '項目の追加に失敗しました。'
      render :new
    end
  end

  def edit
    @travel = @budget_item.travel
  end
  
  def update
    
    if @budget_item.update(budget_item_params)
      flash[:success] = '項目を更新しました。'
      redirect_to budget_items_path(@budget_item.travel)
    else
      flash.now[:danger] = '項目の更新に失敗しました。'
      render :edit
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
  
  def set_travel
    @travel = Travel.find(params[:id])
  end
  
  def correct_user
    @budget_item = BudgetItem.find(params[:id])
    unless @budget_item.travel.user == @current_user
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
