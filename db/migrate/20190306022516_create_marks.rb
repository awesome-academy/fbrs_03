class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
