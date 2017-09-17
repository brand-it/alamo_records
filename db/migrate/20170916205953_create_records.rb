# frozen_string_literal: true

class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.string :title
      t.integer :year
      t.integer :condition

      t.timestamps
    end
  end
end
