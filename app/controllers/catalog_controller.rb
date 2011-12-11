class CatalogController < ApplicationController
  def category
    @perpage = params[:perpage].to_i > 0 ? params[:perpage].to_i : 20
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @search = params[:search] || {:meta_sort => 'name.desc'}
  
    @category = Category.find(params[:category_id])
    @goods = @category.site_goods.visible.
                  page(@page).per(@perpage)#.
                  #search(@search)
    params.delete(:category_id)
  end

  def good
    @category = Category.find(params[:category_id])
    @good = Good.find(params[:good_id])
  end

  def compare
    @goods = Good.find(session[:compare], :include => :category)
  end

  def add_to_compare
    @good = Good.visible.find(params[:good_id])
    
    if @good && @good.category.visible &&
       !session[:compare].include?(@good.id)
      session[:compare] << @good.id
    end
    
    redirect_to catalog_compare_path
  end

  def remove_from_compare
    good_id = params[:good_id].to_i
    session[:compare].delete(good_id)
    
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
    
    if !params[:search].nil?
      @goods = @search.relation.visible#.page(@page).per(@perpage)
    else
      @goods = []
    end
  end

end
