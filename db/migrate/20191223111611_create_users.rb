class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_id,                 null: false, limit: 50
      t.string :encrypted_password,      null: false
      t.string :last_name,               null: false, limit: 50
      t.string :first_name,              null: false, limit: 50
      t.string :email,                   null: false, limit: 100
      t.string :microsite,               null: false, limit: 50
      t.string :user_type,               limit: 30
      t.string :phone,                   limit: 30


      t.string :date_format,             limit: 20
      t.string :number_format,           limit: 2
      t.string :time_format,             limit: 20
      t.string :language,                limit: 5


      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # Lockable
      t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at


      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at


      t.string :created_by,              limit: 50
      t.string :updated_by,              limit: 50
      t.timestamps


      # t.integer  "login_attempts"
      # t.string  "reset_password_question", limit: 2
      # t.string  "reset_password_answer",   limit: 50
      # t.integer  "saved_cart_id"
      # t.boolean  "force_password_change"
      # t.boolean  "active"
      # t.boolean  "complete"
      # t.string  "hashed_password"
      # t.string  "salt"
      # t.datetime "first_activation"
      # t.datetime "first_login"
      # t.datetime "last_login"
      # t.integer  "total_logins"
      # t.string  "order_search_default",    limit: 10
      # t.string  "invoice_search_default",  limit: 10
      # t.integer  "closed_news_id"
      # t.date     "password_change_date"
      # t.string  "approver_email"
      # t.integer  "saved_return_id"
      # t.integer  "saved_quote_id"
      # t.integer  "saved_rfq_id"
    end

    add_index :users, :email,                :unique => true
    add_index :users, :user_id,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end
