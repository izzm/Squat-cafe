class CartController < ApplicationController
  def index
    @goods = Good.find(session[:cart].keys, :include => :category)
  end

  def add_good
    @good = Good.visible.find(params[:good_id])
    
    if @good && @good.category.visible
      session[:cart][@good.id] ||= {}
      session[:cart][@good.id][:order_parameters] = params[:order_parameters]
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
