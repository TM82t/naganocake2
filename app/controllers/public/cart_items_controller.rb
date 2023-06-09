class Public::CartItemsController < ApplicationController
  #before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
    @total_payment = 0
  end

  def create
    @cart_items = current_customer.cart_items.all
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to cart_items_path
    elsif @cart_item.save
      @cart_items = current_customer.cart_items.all
      render 'index'
    else
      render 'index'
    end
  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id,:price,:image_id,:amount)
  end
end
