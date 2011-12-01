class StaticPageConstraint
  def self.matches?(request)
    page = StaticPage.select([:id, :visible]).find_by_url_path(request.params[:path])

    constraint_result = (!page.nil? && page.visible)
    request.params[:page_id] = page.id if constraint_result

    return constraint_result
  end
end
