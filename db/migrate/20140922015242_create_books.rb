class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :author, index: true
      t.string :title
      t.string :blurb
      t.string :description
      t.string :admin_notes

      t.timestamps
    end
  end
end
