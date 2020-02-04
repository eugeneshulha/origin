class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uuid,                    null: false, index: { unique: true }
      t.string :username,                null: false, limit: 50, index: { unique: true }
      t.string :encrypted_password,      null: false
      t.string :last_name,               null: false, limit: 50
      t.string :first_name,              null: false, limit: 50
      t.string :email,                   null: false, limit: 100, index: true
      t.string :user_type,               limit: 30
      t.string :phone,                   limit: 30

      t.string :date_format,             limit: 20
      t.string :number_format,           limit: 2
      t.string :time_format,             limit: 20
      t.string :time_zone
      t.string :language,                limit: 5
      t.boolean :active,                 default: false

      ## Trackable
      t.integer :sign_in_count,          null: false, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # Lockable
      t.integer  :failed_attempts,       null: false, default: 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Recoverable
      t.string   :reset_password_token, index: { unique: true }
      t.datetime :reset_password_sent_at

      t.belongs_to :microsite
      t.belongs_to :user_type
      t.belongs_to :user_classification

      t.string :created_by,              limit: 50
      t.string :updated_by,              limit: 50
      t.timestamps
    end
  end
end
