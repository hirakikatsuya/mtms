# frozen_string_literal: true

class CreateTrainings < ActiveRecord::Migration[6.1]
  def change
    create_table :trainings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
      t.datetime :start_time, null: false

      t.timestamps
    end
  end
end
