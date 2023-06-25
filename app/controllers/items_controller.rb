class ItemsController < ApplicationController
  before_action :set_user

  # GET /users/:user_id/items
  def index
    items = @user.items
    render json: items
  end

  # GET /users/:user_id/items/:id
  def show
    item = @user.items.find_by(id: params[:id])
    if item
      render json: item
    else
      render json: { error: "Item not found" }, status: :not_found
    end
  end

  # POST /users/:user_id/items
  def create
    item = @user.items.build(item_params)
    if item.save
      render json: item, status: :created
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
    render json: { error: "User not found" }, status: :not_found unless @user
  end

  def item_params
    params.permit(:name, :description, :price)
  end
end
