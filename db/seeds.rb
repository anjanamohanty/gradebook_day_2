# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

t1 = Teacher.create!(name: "Mrs. Rollins", email: "rollins@mail.com", password: "rollinsisateacher")
t2 = Teacher.create!(name: "Mr. Fidel", email: "fidel@mail.com", password: "fidelisateacher")

s1 = Student.create!(name: "Ruti", email: "ruti@mail.com", teacher: t1, password: "ruti")
s2 = Student.create!(name: "Da-Me", email: "dame@mail.com", teacher: t1, password: "dame")

p1 = Parent.create!(name: "Geeta", email: "geeta@mail.com", student: s1, password: "geeta")
p2 = Parent.create!(name: "Sushant", email: "sushant@mail.com", student: s1, password: "sushant")

g1 = Grade.create!(assignment_name: "Homework A", grade: "A", student_id: s1.id)
g2 = Grade.create!(assignment_name: "Homework B", grade: "B+", student_id: s1.id)
