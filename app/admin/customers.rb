ActiveAdmin.register Customer do
  scope :all_customers, :default => true
  scope :individual
  scope :corporate

  filter :name
  filter :email
  filter :phone

  actions :index, :show, :edit, :update, :destroy

  index do
    column :name do |customer| 
      link_to customer.name, admin_customer_path(customer)
    end
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

  show :title => :name_with_email do
    panel I18n.t('active_admin.titles.customer.order_history') do
      table_for(customer.orders) do
        column(I18n.t('activerecord.attributes.order.number'), :sortable => :id) { |order| 
          link_to "##{order.number}", admin_order_path(order)
        }
        
        column(I18n.t('activerecord.attributes.order.state')) { |order|
          status_tag(I18n.t("active_admin.scopes.#{order.state}"))
        }

        column(I18n.t('activerecord.attributes.order.created_at'), :sortable => :created_at) { |order|
          pretty_format(order.created_at) 
        }

        column(I18n.t('activerecord.attributes.order.total_price')) { |order| 
          number_to_currency order.total_price 
        }
      end
    end
  
    active_admin_comments
  end

  sidebar I18n.t('active_admin.titles.customer.customer_details'), :only => :show do
    attributes_table_for customer, :name, :company, :phone, :email, :created_at, :first_order
  end

  sidebar I18n.t('active_admin.titles.customer.order_info'), :only => :show do
    attributes_table_for customer do
      row(:total_orders) { customer.orders.complete.count }
      row(:total_value) { number_to_currency customer.orders.complete.sum(:total_price) }
    end
  end  
 
 
end if false
