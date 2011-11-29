class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :company, :corporate, :phone, :email, :password, :password_confirmation, :remember_me

  scope :individual, where(:corporate => false)
  scope :corporate, where(:corporate => true)

  has_many :orders
end
