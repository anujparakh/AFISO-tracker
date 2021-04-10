class AddedSecondSemesterToDues < ActiveRecord::Migration[6.1]
  def change
	rename_column :dues, :semester_id, :semester_id_1
	add_column :dues, :semester_id_2, :bigint
  end
end
