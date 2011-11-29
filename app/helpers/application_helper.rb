module ApplicationHelper
  def render_table_tree(hash, options = {}, &block)
    sort_proc = options.delete :sort
    hash.keys.sort_by(&sort_proc).each do |node|
      block.call node
      render_table_tree(hash[node], :sort => sort_proc, &block)  
    end if hash.present?
  end
end
