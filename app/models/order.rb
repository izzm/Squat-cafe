class Order < ActiveRecord::Base
  belongs_to :customer

  has_many :order_goods, :dependent => :destroy
  accepts_nested_attributes_for :order_goods
  
  scope :new_orders, where("orders.checked_out_at IS NULL and orders.delivery_at IS NULL")
  scope :in_progress,  where("orders.checked_out_at IS NULL and orders.delivery_at IS NOT NULL")
  scope :complete, where("orders.checked_out_at IS NOT NULL")
  scope :canceled, where(:canceled => true)
  
  NEW_ORDER = "new_order"
  COMPLETE = "complete"
  IN_PROGRESS = "in_progress"
  CANCELED = "canceled"

#  def self.find_with_product(product)
#    return [] unless product
#    
#    self.complete.includes(:line_items).
#      where(["line_items.product_id = ?", product.id]).
#      order("orders.checked_out_at DESC")
#  end

  def checkout!
    self.checked_out_at = Time.now
    self.save
  end

  def recalculate_price!
    #self.total_price = line_items.inject(0.0){|sum, line_item| sum += line_item.price }
    #save!
  end

  def state
    self.canceled ? CANCELED :
      (!checked_out_at.nil? ? COMPLETE :
        (delivery_at.nil? ? NEW_ORDER : IN_PROGRESS))
  end

  def display_name
    ActionController::Base.helpers.number_to_currency(total_price) + 
       " - Order ##{id} (#{user.username})"
  end
end
