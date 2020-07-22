class GuestSessionsController < ApplicationController
  
  def create
    user = User.find_by(email: 'guestuser@example.com')
    login(user)
    flash[:success] = 'ゲストユーザーでログインしました'
    redirect_to travels_path
  end
  
  private
  
  def login(user)
    session[:user_id] = user.id
  end
end
