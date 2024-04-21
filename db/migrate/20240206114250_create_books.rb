class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.integer :user_id
      t.text :body
      t.string :title

      t.timestamps
    end
  end
end
