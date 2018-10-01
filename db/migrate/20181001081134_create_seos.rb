class CreateSeos < ActiveRecord::Migration[5.2]
  def change
    create_table :seos do |t|
      t.string :title
      t.text :description
      t.string :keywords, array: true
      t.references :seoable, polymorphic: true

      t.timestamps
    end
  end
end
