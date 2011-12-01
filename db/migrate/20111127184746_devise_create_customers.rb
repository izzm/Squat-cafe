class DeviseCreateCustomers < ActiveRecord::Migration
  def change
    create_table(:customers) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.string :name
      t.string :company
      t.boolean :corporate, :default => false
      t.date :first_order      
      t.string :phone

      t.timestamps
    end

    add_index :customers, :email,                :unique => true
    add_index :customers, :reset_password_token, :unique => true
    # add_index :customers, :confirmation_token,   :unique => true
    # add_index :customers, :unlock_token,         :unique => true
    # add_index :customers, :authentication_token, :unique => true
  end

end
