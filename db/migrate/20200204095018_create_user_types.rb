class CreateUserTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_types do |t|
      t.string :title
      t.string :value
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
