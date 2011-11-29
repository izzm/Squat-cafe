require 'acts_as_breadcrumbs'
require 'rails/railtie'

module ActiveRecord #:nodoc:
  module Acts #:nodoc:
    module Breadcrumbs
      class Railtie < ::Rails::Railtie
        config.before_initialize do
          ActiveSupport.on_load :active_record do
            include ActiveRecord::Acts::Breadcrumbs::Base
          end
        end

        def self.extend_active_record
          ActiveRecord::Base.send :include, ActiveRecord::Acts::Breadcrumbs::Base
        end
      end
    end
  end
end
