class GoodConstraint
  def self.matches?(request)
    good = Good.select([:id, :category_id, :visible]).
                find(request.params[:id])
    return false if good.nil? || !good.visible

    category = Category.select([:id, :virtual, :visible]).
                        find_by_url_path(request.params[:path])
    return false if category.nil? || !category.visible
    
    if good.present_in? category
      request.params[:category_id] = category.id
      request.params[:good_id] = good.id
      
      return true
    end

    return false
  end
end
