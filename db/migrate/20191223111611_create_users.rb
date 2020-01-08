class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uuid,                    null: false, default: SecureRandom.uuid, index: true, unique: true
      t.string :username,                null: false, limit: 50, index: true, unique: true
      t.string :encrypted_password,      null: false
      t.string :last_name,               null: false, limit: 50
      t.string :first_name,              null: false, limit: 50
      t.string :email,                   null: false, limit: 100, index: true
      t.string :microsite,               null: false, limit: 50
      t.string :user_type,               limit: 30
      t.string :phone,                   limit: 30


      t.string :type,                    limit: 30 ## STI


      t.string :date_format,             limit: 20
      t.string :number_format,           limit: 2
      t.string :time_format,             limit: 20
      t.string :language,                limit: 5


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
      t.string   :reset_password_token,  index: true, unique: true
      t.datetime :reset_password_sent_at


      t.string :created_by,              limit: 50
      t.string :updated_by,              limit: 50
      t.timestamps
    end
  end
end
