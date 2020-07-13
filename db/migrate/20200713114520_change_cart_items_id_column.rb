class ChangeCartItemsIdColumn < ActiveRecord::Migration[5.2]
  def up
    add_column :cart_items, :uuid, :string

    CorevistAPI::Cart::Item.transaction do
      CorevistAPI::Cart::Item.all.each { |item| item.update(uuid: SecureRandom.uuid) }
    end

    remove_column :cart_items, :id
    rename_column :cart_items, :uuid, :id
    execute 'ALTER TABLE cart_items ADD PRIMARY KEY (id);'
  end

  def down
    remove_column :cart_items, :id
    add_column :cart_items, :id, :primary_key
  end
end
