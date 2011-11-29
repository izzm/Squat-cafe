module FormtasticNestedSet
  module Hooks
    module FormtasticBuilder
      def self.included(base)
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        include FormtasticNestedSet::Helper

        def nested_set_input(method, options)
          html_options = options.delete(:input_html) || {}
          html_options[:multiple] = html_options[:multiple] || options.delete(:multiple)
          html_options.delete(:multiple) if html_options[:multiple].nil?

          reflection = reflection_for(method)
          if reflection && [ :has_many, :has_and_belongs_to_many ].include?(reflection.macro)
            html_options[:multiple] = true if html_options[:multiple].nil?
            html_options[:size]     ||= 5
            options[:include_blank] ||= false
          end

          options = set_include_blank(options)
          input_name = generate_association_input_name(method)
          html_options[:id] ||= generate_html_id(input_name, "")

          select_html = if true
            #collection = find_collection_for_column(method, options)
            relation_class = reflection_for(method).klass
            mover = @object#.class == relation_class ? @object : nil

            #ActiveRecord::Base.logger.info mover.to_yaml
            #ActiveRecord::Base.logger.info relation_class
            #ActiveRecord::Base.logger.info @object.class

            select(input_name, 
                   sorted_nested_set_options(relation_class, lambda(&:position), mover) {|i, level| "#{'-' * level} #{i.to_s}" },
                   strip_formtastic_options(options), 
                   html_options)
            

            #select(input_name, collection, strip_formtastic_options(options), html_options)
            #select_tag 'parent_id', options_for_select(sorted_nested_set_options(StaticPage, lambda(&:position)) {|i, level| "#{'-' * level} #{i.title}" }), :include_blank => true
          end

          label_options = options_for_label(options).merge(:input_name => input_name)
          label_options[:for] ||= html_options[:id]
          label(method, label_options) << select_html
        end
      end
    end
  end
end
