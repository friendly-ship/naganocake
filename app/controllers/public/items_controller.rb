class Public::ItemsController < ApplicationController
  def index
    @items = Item.where(is_active: true).page(params[:page]).per(8) 
    @quantity = Item.count
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

  def search
    @items = Item.where(genre_id: params[:format]).page(params[:page]).per(8)
    @quantity = Item.where(genre_id: params[:format]).count
    @genres = Genre.all
    render 'index'
  end
end
