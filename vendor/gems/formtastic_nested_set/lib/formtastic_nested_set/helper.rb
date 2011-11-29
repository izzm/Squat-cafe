module FormtasticNestedSet
  module Helper
    def sorted_nested_set_options(class_or_item, sort_proc, mover = nil, level = 0)
      hash = if class_or_item.is_a?(Class)
          class_or_item
        else
          class_or_item.self_and_descendants
        end.arrange

      build_node(hash, sort_proc, mover, level){|x, lvl| yield(x, lvl)}
    end

    def build_node(hash, sort_proc, mover = nil, level = nil)
      result = []
      hash.keys.sort_by(&sort_proc).each do |node|
        if mover.nil? || mover.new_record? || mover.move_possible?(node)
          result.push([yield(node, level.to_i), node.id])
          result.push(*build_node(hash[node], sort_proc, mover, level.to_i + 1){|x, lvl| yield(x, lvl)})
        end
      end if hash.present?
  
      result
    end 
  end
end

