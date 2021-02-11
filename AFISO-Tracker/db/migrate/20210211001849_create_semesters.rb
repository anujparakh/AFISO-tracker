class CreateSemesters < ActiveRecord::Migration[6.1]
  def change
    create_table :semesters do |t|
      t.datetime :startDate
      t.datetime :endDate
      t.string :semesterName

      t.timestamps
    end
  end
end
