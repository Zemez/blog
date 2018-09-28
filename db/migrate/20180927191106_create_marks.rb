class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :mark

      t.timestamps
    end
    # один пользователь = одна оценка?
    add_index :marks, [:post_id, :user_id], unique: true
  end
end
