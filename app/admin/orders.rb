ActiveAdmin.register Order do
  actions :index, :show

  filter :total_price
  #filter :checked_out_at

  scope :all
  scope :new_orders, :default => true
  scope :in_progress
  scope :complete
  scope :canceled

  index do
    column("Order", :sortable => :id) { |order| 
      link_to "##{order.id} ", admin_order_path(order) 
    }
    
    column("State") { |order| 
      status_tag(order.state)
    }

    column("Date", :created_at)
    column("Customer", :customer)
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

    active_admin_comments
  end

  sidebar :customer_information, :only => :show do
    attributes_table_for order.customer do
      row("User") { auto_link order.customer }
      #row :emal
    end
  end  
end
