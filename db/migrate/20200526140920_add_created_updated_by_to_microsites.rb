class AddCreatedUpdatedByToMicrosites < ActiveRecord::Migration[5.2]
  def change
    add_column :microsites, :created_by, :string, null: false, default: :system
    add_column :microsites, :updated_by, :string, default: :system
    add_column :microsites, :created_at, :datetime, null: false, default: DateTime.now
    add_column :microsites, :updated_at, :datetime, default: DateTime.now
  end
end
