require 'rails'

# FormtasticNestedSet
module FormtasticNestedSet
  class Engine < ::Rails::Engine
    initializer 'formtastic.nestedset' do
      if Object.const_defined?("Formtastic")
        ::Formtastic::SemanticFormBuilder.send :include, FormtasticNestedSet::Hooks::FormtasticBuilder
      end
    end
  end
end
