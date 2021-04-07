# frozen_string_literal: true

class CreateSemesters < ActiveRecord::Migration[6.1]
  def change
    create_table :semesters do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :dues_deadline
      t.string :semester_name

      t.timestamps
    end
  end
end
