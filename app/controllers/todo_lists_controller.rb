class TodoListsController < ApplicationController
  before_action :set_todo_list, :only => [:show, :edit, :update, :destroy]

  def index
    @todo_lists = TodoList.order(due_date: :asc)
  end

  def new
    @todo_list = TodoList.new
  end

  def create
    @todo_list = TodoList.new(todo_list_params)
    if @todo_list.save
      redirect_to todo_lists_url
    else
      render :action => :new
    end  
  end

  def update
    if @todo_list.update_attributes(todo_list_params)
      redirect_to todo_list_path(@todo_list)
    else
      render  :action => :edit
    end
  end

  def destroy    
    if @todo_list.can_destroy?
      @todo_list.destroy
      flash[:alert] = 'List was successfully deleted !!'
      redirect_to todo_lists_path
    else
      # 跳出警告訊息，告知過期
      flash[:alert] = 'List is overdue, can not be deleted !!'
      # 重新發出 request，導往列表頁。對瀏覽器來說會重整頁面
      redirect_to todo_lists_path
    end            
  end
   
  private

  def todo_list_params
    params.require(:todo_list).permit(:title, :due_date, :description)
  end

  def set_todo_list
     @todo_list = TodoList.find(params[:id])
  end
end
