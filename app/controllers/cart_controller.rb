class CartController < ApplicationController
  before_filter :authenticate_customer!,
                :except => [:add_good]

  def index
    @goods = Good.find(session[:cart].keys, :include => :category)
  end

  def add_good
    @good = Good.visible.find(params[:good_id])
    
    if @good && @good.category.visible
      session[:cart][@good.id] ||= {}
      session[:cart][@good.id][:good_id] = @good.id
      session[:cart][@good.id][:variant] = params[:variant]
      session[:cart][@good.id][:count] ||= 0
      session[:cart][@good.id][:count] += 1
      session[:cart][@good.id][:price] = @good.price
    end
    
    session_cart_recalculate(false)
    
    redirect_to cart_path
  end

  def remove_good
    good_id = params[:good_id].to_i
    cart_record = session[:cart][good_id]
    
    if !cart_record.nil?
      session[:cart].delete(good_id)
    end
    
    session_cart_recalculate(false)
    
    redirect_to cart_path
  end

  def recalculate
    session_cart_recalculate(true)
    
    redirect_to cart_path
  end

  def purchase
    @order = Order.new

    @order.order_goods_attributes = session[:cart]
    @order.total_price = session[:cart_price]

    @order.save

    redirect_to cart_path
  end
  
protected
  def session_cart_recalculate(use_params)
    session[:cart_count] = 0
    session[:cart_price] = 0
    
    session[:cart].each { |good_id, cart_record|
      if use_params
        new_count = (params[:counts].try('[]', good_id.to_s) || cart_record[:count]).to_i
      else
        new_count = cart_record[:count]
      end
      
      session[:cart_count] += 1
      session[:cart_price] += cart_record[:price] * new_count
      
      session[:cart][good_id][:count] = new_count
    }
  end

end
