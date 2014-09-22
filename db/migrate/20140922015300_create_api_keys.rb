class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.references :user, index: true
      t.string :access_token
      t.timestamps
    end

    add_index :api_keys, :access_token, unique: true
  end
end
