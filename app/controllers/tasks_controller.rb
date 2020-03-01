class TasksController < ApplicationController
  
  before_action :set_task, only:[:show, :edit, :update, :destroy]
  before_action :require_logged_in, only:[:show, :new, :create, :edit, :update, :destroy]
    
  def index
    if logged_in?
      @task = Task.all
    else
      redirect_to login_url
    end
  end
  
  def show
  end
    
  def new
    @task = Task.new
  end
    
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に追加されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクの追加に失敗しました'
      render :new
    end
  end
  
  def edit
  end
    
  def update
    if @task.update(task_params)
      flash[:success] = 'タスクが正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクの更新に失敗しました'
      render :edit
    end
  end
    
  def destroy
    @task.destroy
    
    flash[:success] = 'タスクをリストから削除しました。お疲れ様でした。'
    redirect_to tasks_url
    
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  

    
end
