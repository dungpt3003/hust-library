class Survey < Sequel::Model
  one_to_many :answers
  many_to_one :library

end
