class CreatePageElements < ActiveRecord::Migration
  def change
    create_table :page_elements do |t|
      t.string :element_type
      t.string :content
      t.references :page, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
