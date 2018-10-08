class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: { on_delete: :cascade }
      t.string :title, index: { unique: true }
      t.text :body
      t.boolean :visible, default: false

      t.timestamps
    end
  end
end
