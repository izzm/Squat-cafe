module ApplicationHelper
  def render_table_tree(hash, options = {}, &block)
    sort_proc = options.delete :sort
    hash.keys.sort_by(&sort_proc).each do |node|
      block.call node
      render_table_tree(hash[node], :sort => sort_proc, &block)  
    end if hash.present?
  end
  
  # METHODS FOR SITE FRONTEND
  
  def site_main_menu
    StaticPage.find_by_link('oltis').children.sorted.visible
  end
  
  def site_catalog_menu
    Category.visible.sorted.roots
  end
end
