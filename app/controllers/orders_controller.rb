class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new(order_params) 
    if @order_form.valid?
      @order_form.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private
  def order_params
    params.permit(:name, :nickname, :postal_code, :prefecture, :city, :addresses, :building, :phone_number, :price)
  end
end
