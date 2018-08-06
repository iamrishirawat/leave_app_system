class HomePageController < ApplicationController
  def homepage
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
    end
  end
end
