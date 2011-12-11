class WishlistGood < ActiveRecord::Base
  belongs_to :customer
  belongs_to :good
end
