ActiveAdmin.register Order do
  actions :index, :show, :edit, :update

  filter :total_price
  #filter :checked_out_at

  scope :all_orders
  scope :new_orders, :default => true
  scope :in_progress
  scope :complete
  scope :canceled

  index do
    column(:number) { |order| 
      content_tag :nobr do 
        link_to "##{order.number} ", admin_order_path(order) 
      end
    }
    
    column(:state) { |order| 
      status_tag(I18n.t("active_admin.scopes.#{order.state}"))
    }

    column(:created_at, :sortable => false)
    column(:delivery_at, :sortable => false)
    column(:checked_out_at, :sortable => false)
    column(:customer, :sortable => false)
    column(:total_price) { |order| 
      number_to_currency order.total_price 
    }
  end

  show :title => lambda{ |order| I18n.t('active_admin.titles.order.show', :number => order.number) } do
    panel "Invoice" do
      table_for(order.order_goods) do |t|
        t.column("Product") {|item| auto_link item.good           }
        t.column("Price")   {|item| number_to_currency item.price }
        
        tr :class => "odd" do
          td "Total:", :style => "text-align: right;"
          td number_to_currency(order.total_price)
        end
      end
    end

    panel "Info" do
      attributes_table_for order do
        row("Created") { order.created_at }
        row("Delivery") { order.delivery_at }
        row("Complete") { order.checked_out_at }

        row :delivery_type
        row :address
        row :comment
      end
    end

    active_admin_comments
  end

  sidebar :customer_information, :only => :show do
    attributes_table_for order.customer do
      row("User") { auto_link order.customer }
      row :email
    end
  end  
end
