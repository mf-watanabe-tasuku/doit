class TodosController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :logged_in_user
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  def index
    redirect_to new_todo_path
  end

  def show; end

  def new
    @todo = Todo.new
    @todo.todo_date = @todo.todo_date || @today
  end

  def create
    @todo = current_user.todos.build(todo_params)
    if @todo.save
      flash[:success] = 'ToDoが追加されました。'
      redirect_to dashboard_path(@todo.todo_date)
    else
      render action: 'new'
    end
  end

  def edit; end

  def update
    @todo.assign_attributes(todo_params)
    if @todo.save
      flash[:success] = 'ToDoが更新されました。'
      redirect_to dashboard_path(@todo.todo_date)
    else
      render action: 'edit'
    end
  end

  def destroy
    @todo.destroy
    flash[:success] = 'ToDoが削除されました。'
    redirect_to request.referer
  end

  def create_shortcut
    @todo = Todo.find(params[:todo_id])
    shortcut = current_user.shortcuts.build(title: @todo.title)
    if shortcut.save
      flash[:success] = 'ショートカットが作成されました。'
      redirect_to @todo
    else
      flash[:danger] = shortcut.errors.messages.values[0][0]
      redirect_to @todo
    end
  end

  def toggle_status
    render body: nil
    @todo = Todo.find(params[:todo_id])
    @todo.status = !@todo.status
    @todo.save
  end

  private

  def set_user
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :body, :status, :todo_date)
  end
end
