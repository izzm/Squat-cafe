module FormtasticNestedSet
  module Hooks
    autoload :FormtasticBuilder, 'formtastic_nested_set/hook.rb'
  end

  autoload :Helper, 'formtastic_nested_set/helper.rb'
end

require 'formtastic_nested_set/engine.rb'
