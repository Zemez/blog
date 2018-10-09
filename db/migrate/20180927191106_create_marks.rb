class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.references :post, foreign_key: { on_delete: :cascade }
      t.references :user, foreign_key: { on_delete: :cascade }
      t.integer :mark

      t.timestamps
    end
    # один пользователь = одна оценка?
    add_index :marks, [:post_id, :user_id], unique: true
  end
end
