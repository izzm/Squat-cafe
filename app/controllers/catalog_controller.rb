class CatalogController < ApplicationController
  def category
    @perpage = params[:perpage].to_i > 0 ? params[:perpage].to_i : 20
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @cat_filter = params[:cat_filter].to_i
    search_p = params[:search] || {:meta_sort => 'name.desc'}
    @search_param = (search_p[:meta_sort] || "name.desc").split('.').first

    @category = Category.find(params[:category_id])
    if @cat_filter > 0
      @filter_category = Category.find(@cat_filter)
      @goods = @filter_category.site_goods.
                visible.includes(:category).
                page(@page).per(@perpage).
                has_virtual_category(@category)
    else
      @goods = @category.site_goods.#unscoped.
                    visible.includes(:category).
                    page(@page).per(@perpage)
    end
    
    @search = @goods.search(search_p)
    params.delete(:category_id)
  end

  def good
    @category = Category.find(params[:category_id])
    @good = Good.find(params[:good_id])
  end

  def compare
    @categories = {}

    ActiveRecord::Base.logger.info session[:compare].to_yaml

    session[:compare].each { |category_id, good_ids|
      name = Category.find_by_id(category_id).try(:name) || 'not'
      @categories[name] = Good.find_all_by_id(good_ids, :include => :category)
    }
  end

  def add_to_compare
    @good = Good.visible.find(params[:good_id])
    
    if @good && @good.category.visible
      @category = @good.category.self_and_ancestors[1]
      session[:compare][@category.id] ||= []

      if @category && !session[:compare][@category.id].include?(@good.id)
        session[:compare][@category.id] << @good.id
      end
    end
    
    redirect_to request.referrer#catalog_compare_path
  end

  def remove_from_compare
    good_id = params[:good_id].to_i
    
    @good = Good.find(good_id)
    if @good
      @category = @good.category.self_and_ancestors[1]
      session[:compare][@category.id] ||= []

      if @category
        session[:compare][@category.id].delete(good_id)
      end
    end
    
    redirect_to catalog_compare_path
  end

  def search
    @perpage = params[:perpage].to_i > 0 ? params[:perpage].to_i : 20
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1

    if params[:single_search] && params[:single_search].size >= 3
      @search = Good.search :name_contains => params[:single_search]
    else
      @search = Good.search(params[:search])
    end
    
    if !params[:search].nil? || !params[:single_search].nil?
      @goods = @search.relation.visible#.page(@page).per(@perpage)
    else
      @goods = []
    end
  end

end
