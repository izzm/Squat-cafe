class CatalogController < ApplicationController
  def index
    if Category.site_roots.navigation.count > 0
      redirect_to category_path(Category.site_roots.navigation.first.url_path)
    else
      redirect_to root_path
    end
  end

  def category
    @category = Category.find(params[:category_id])
    @roots = Category.site_roots.navigation
    
    @subcats = Category.site_children(@category).navigation
  end
  
  def export
    @goods = Good.to_export.sorted
    @categories = Category.of_goods(@goods).sort_by!(&:position)
  end
=begin
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
=end
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
    #@perpage = params[:perpage].to_i > 0 ? params[:perpage].to_i : 20
    #@page = params[:page].to_i > 0 ? params[:page].to_i : 1

    if params[:keyword].size >= 3
      @search_goods_name = Good.search :name_contains => params[:keyword]
      @search_goods_description = Good.search :description_contains => params[:keyword]
      
      @search_category_name = Category.search :name_contains => params[:keyword]
      @search_category_description = Category.search :description_contains => params[:keyword]
      
      @search_static_page_title = StaticPage.search :title_contains => params[:keyword]
      @search_static_page_content = StaticPage.search :content_contains => params[:keyword]

      @search_event_name = Event.search :name_contains => params[:keyword]
      @search_event_short_description = Event.search :short_description_contains => params[:keyword]
      @search_event_description = Event.search :description_contains => params[:keyword]

    end
    
    # site wide search
    if defined? @search_goods_name
      #.page(@page).per(@perpage)
      @goods = @search_goods_name.relation.visible
      @goods += @search_goods_description.relation.visible
      @goods = (@goods || []).compact.uniq
      
      @categories = @search_category_name.relation.visible
      @categories += @search_category_description.relation.visible
      @categories = (@categories || []).compact.uniq

      @pages = @search_static_page_title.relation.visible
      @pages += @search_static_page_content.relation.visible
      @pages = (@pages || []).compact.uniq

      @events = @search_event_name.relation.visible
      @events += @search_event_short_description.relation.visible
      @events += @search_event_description.relation.visible
      @events = (@events || []).compact.uniq
    else
      @goods = @categories = @pages = @events = []
    end
  end

end
