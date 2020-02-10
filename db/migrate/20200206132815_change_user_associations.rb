class ChangeUserAssociations < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.remove :user_classification_id
      t.string :user_classification_id, index: true, foreign_key: true
    end
  end
end
