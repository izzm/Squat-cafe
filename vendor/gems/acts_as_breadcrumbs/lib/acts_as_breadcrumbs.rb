module ActiveRecord
  module Acts
    module Breadcrumbs
      autoload :Base, 'acts_as_breadcrumbs/base'
    end
  end
end

require 'acts_as_breadcrumbs/railtie'
