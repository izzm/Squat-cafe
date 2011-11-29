ActiveAdmin.register Customer do
  scope :all, :default => true
  scope :individual
  scope :corporate

  filter :name
  filter :email
  filter :phone

  actions :index, :show, :edit, :update, :destroy

  index do
    column :name
    column :company
    column :phone
    column :email do |customer|
      link_to customer.email, admin_customer_path(customer)
    end

    column :order_count do |customer|
      "#{customer.orders.count}"
    end

    column :first_order
  end

  form do |f|
    f.inputs :info do
      f.input :name
      f.input :company
      f.input :corporate
    end

    f.inputs :contact_info do
      f.input :email
      f.input :phone
    end

    f.buttons
  end

  show :title => :name do
    panel I18n.t('order_history') do
      table_for(customer.orders) do
        column("Order", :sortable => :id) { |order| 
          link_to "##{order.id}", admin_order_path(order)
        }
        
        column("State") { |order|
          status_tag(order.state)
        }

        column("Date", :sortable => :checked_out_at) { |order|
          pretty_format(order.checked_out_at) 
        }

        column("Total") { |order| 
          number_to_currency order.total_price 
        }
      end
    end
  
    active_admin_comments
  end

  sidebar :customer_details, :only => :show do
    attributes_table_for customer, :name, :company, :corporate, :phone, :email, :created_at, :first_order
  end

  sidebar :order_history, :only => :show do
    attributes_table_for customer do
      row(:total_orders) { customer.orders.complete.count }
      row(:total_value) { number_to_currency customer.orders.complete.sum(:total_price) }
    end
  end  
 
 
end
