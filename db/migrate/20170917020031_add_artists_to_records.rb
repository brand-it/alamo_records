# frozen_string_literal: true

class AddArtistsToRecords < ActiveRecord::Migration[5.1]
  def change
    add_reference :records, :artist, foreign_key: true
  end
end
