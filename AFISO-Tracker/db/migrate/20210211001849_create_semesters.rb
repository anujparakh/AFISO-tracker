class CreateSemesters < ActiveRecord::Migration[6.1]
  def change
    create_table :semesters do |t|
      t.Date :startDate
      t.Date :endDate
      t.string :semesterName

      t.timestamps
    end
  end
end
