class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :author_id, null: false

      t.timestamps
    end

    add_foreign_key :likes, :users, column: :author_id
  end
end
