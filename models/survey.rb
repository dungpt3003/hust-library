class Survey < Sequel::Model
  one_to_many :answers
  many_to_one :library

  USER_ROLES = [
    "Student",
    "Staff",
    "Teacher",
    "Guest"
  ]

end
