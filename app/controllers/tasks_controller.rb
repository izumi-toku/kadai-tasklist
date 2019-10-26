class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:update, :destroy]
  
  def index
    #@tasks = Task.all.page(params[:page]).per(10)
    @tasks = Task.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  def show
     set_task
     if @task.user_id != current_user.id 
      redirect_to root_url, alert: "ユーザーが違います。"
     end
  end


  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクが投稿されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render 'new'
    end
  end

  def edit
    set_task
  end

  def update
    set_task
    
    if @task.update(task_params)
        flash[:success] = 'タスクが更新されました'
        redirect_to root_url
    else
        flash.now[:danger] = 'タスクが更新されませんでした'
        render 'new'
    end
  end
 
  def destroy
        @task.destroy
         flash[:success] = 'タスクが削除されました'
         redirect_to tasks_path
  end
  
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
