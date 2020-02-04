class CreateUserClassifications < ActiveRecord::Migration[5.2]
  def change
    create_table :user_classifications, id: :string do |t|
      t.string :title, null: false, default: ''
    end
  end
end
