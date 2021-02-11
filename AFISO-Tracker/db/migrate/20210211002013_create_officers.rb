class CreateOfficers < ActiveRecord::Migration[6.1]
  def change
    create_table :officers do |t|
      t.string :name
      t.string :email
      t.integer :privelegeLevel

      t.timestamps
    end
  end
end
