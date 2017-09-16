class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.string :title
      t.string :year
      t.integer :condition

      t.timestamps
    end
  end
end
