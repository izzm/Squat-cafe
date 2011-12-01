class CategoryConstraint
  def self.matches?(request)
    #ActiveRecord::Base.logger.debug request.params[:path].to_json
    
    category = Category.select([:id, :visible]).find_by_url_path(request.params[:path])

    constraint_result = (!category.nil? && category.visible)
    request.params[:category_id] = category.id if constraint_result
    #ActiveRecord::Base.logger.debug category.to_json
    return constraint_result
  end
end
