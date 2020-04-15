class CreateJwtTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :jwt_tokens do |t|
      t.string :access_jti, null: false
      t.datetime :access_exp, null: false
      t.string :refresh_jti, null: false
      t.datetime :refresh_exp, null: false

      t.belongs_to :user
    end
  end
end
