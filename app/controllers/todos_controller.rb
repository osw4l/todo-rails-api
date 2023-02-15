class TodosController < ApplicationController
  before_action :authorize_request
  before_action :set_todo, only: [:show, :update, :destroy, :complete]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /todos
  def index
    @todos = @current_user.todos

    render json: @todos
  end

  # GET /todos/1
  def show
    render json: @todo
  end

  # POST /todos
  def create
    @todo = @current_user.todos.build(todo_params)

    if @todo.save
      render json: @todo, status: :created, location: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
  end

  # PUT /todos/1
  def complete
    if @todo.completed
      render json: {error: 'To-do already completed'}, status: :unprocessable_entity
    else
      @todo.complete!
      render json: {message: 'To-do completed successfully'}, status: :ok
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    # I'm filter over all the todos that belongs to the user
    @todo = @current_user.todos.find(params[:id])
    raise ActiveRecord::RecordNotFound.new("Todo with ID=#{params[:id]} not found") unless @todo
  end

  # Only allow a list of trusted parameters through.
  def todo_params
    params.permit(:title, :description)
  end

  def record_not_found
    render json: { error: "To-do not found" }, status: :not_found
  end
end
