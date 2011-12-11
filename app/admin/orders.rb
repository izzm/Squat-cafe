ActiveAdmin.register Order do
  actions :index, :show, :edit, :update

  filter :total_price
  #filter :checked_out_at

  scope :all
  scope :new_orders, :default => true
  scope :in_progress
  scope :complete
  scope :canceled

  index do
    column("Order") { |order| 
      content_tag :nobr do 
        link_to "##{order.number} ", admin_order_path(order) 
      end
    }
    
    column("State") { |order| 
      status_tag(order.state)
    }

    column("Created", :created_at, :sortable => false)
    column("Delivery", :delivery_at, :sortable => false)
    column("Complete", :checked_out_at, :sortable => false)
    column("Customer", :customer, :sortable => false)
    column("Total") { |order| 
      number_to_currency order.total_price 
    }
  end

  show do
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
