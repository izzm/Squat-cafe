class OrderGood < ActiveRecord::Base
  belongs_to :order
  belongs_to :good

  serialize :variant

  def variant
    super || {}
  end
end
