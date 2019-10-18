class ToppagesController < ApplicationController
  def index
    if logged_in?
      @tasklist = current_user.tasklists.build  # form_with 用
      @tasklists = current_user.tasklists.order(id: :desc).page(params[:page])
    end
  end
end