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
  end

  def add_to_compare
  end

  def remove_from_compare
  end

  def search
  end

end
