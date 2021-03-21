# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Member.create({ name: 'John Doe', email: 'johndoe@gmail.com'})
Semester.create({ semester_name: 'Fall 2021', start_date: DateTime.now, end_date: DateTime.now + 3, dues_deadline: DateTime.now + 1})
Officer.create({ name: 'Anuj Parakh', email: 'anujparakh@tamu.edu'})