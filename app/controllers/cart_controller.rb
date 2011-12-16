class CartController < ApplicationController
  before_filter :authenticate_customer!,
                :except => [:add_good]

  def index
    load_cart
    @order = Order.new
  end

  def history
    @orders = Order.order('created_at asc').find_all_by_customer_id(current_customer.id)
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
    
    redirect_to request.referrer
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
    @order = Order.new(params[:order])

    @order.order_goods_attributes = session[:cart]
    @order.total_price = session[:cart_price]
    @order.customer = current_customer

    if @order.save
      flash[:order_id] = @order.id
      session_cart_clear
      redirect_to cart_purchase_complete_path
    else
      load_cart
      render :action => :index
      #redirect_to cart_path
    end
  end

  def purchase_complete
    if flash[:order_id].nil?
      redirect_to cart_path
    else
      @order = Order.find(flash[:order_id])
      redirect_to cart_path if @order.nil?
    end
  end
  
protected
  def session_cart_recalculate(use_params = false)
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

  def session_cart_clear
    session[:cart] = {}
    session_cart_recalculate
  end

  def load_cart
    @goods = Good.find(session[:cart].keys, :include => :category)
  end

end
