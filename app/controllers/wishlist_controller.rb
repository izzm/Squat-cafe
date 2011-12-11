class WishlistController < ApplicationController
  before_filter :authenticate_customer!,
                :except => [:add_good]

  def index
    if session[:wishlsit_tmp_good_id]
      new_good = Good.find(session.delete(:wishlsit_tmp_good_id))
      add_good_if_not_present(new_good)
    end

    @goods = current_customer.goods
  end

  def add_good
    @good = Good.visible.find(params[:good_id])
    
    if @good && @good.category.visible
      if current_customer.nil?
        session[:wishlsit_tmp_good_id] = params[:good_id]
      else
        add_good_if_not_present(@good)
      end
    end

    redirect_to wishlist_path
  end

  def remove_good
    @wg = current_customer.wishlist_goods.find_by_good_id(params[:good_id])
    
    if !@wg.nil?
      @wg.delete
    end

    redirect_to wishlist_path
  end

protected
  def add_good_if_not_present(good)
    current_customer.goods << good if !current_customer.goods.include? good
  end

end
