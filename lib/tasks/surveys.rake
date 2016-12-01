desc 'Generate sample data for surveys'
task generate_surveys: :environment do
   roles = ["Student", "Teacher", "Staff", "Guest"]
   names = ["Marie Nelson", "Shawn Simmons", "Edward Coleman", "Anna Garcia", "Walter Baker", "Bonnie Hall", "Carolyn Henderson", "Elizabeth Parker", "Irene Clark", "Lawrence Rogers", "Phyllis Martin", "Paul Wright", "Harry Peterson", "Martin Reed", "Kimberly Stewart", "Fred Perez", "Deborah Allen", "Alice Brown", "Ruth Bailey", "Anthony Russell", "Judith Hernandez", "Arthur Green", "Sean Campbell", "Janice Lee", "Stephen Edwards", "Earl Rodriguez", "Alan Turner", "Theresa Gonzales", "Christopher White", "Mildred Long", "Beverly Foster", "Chris Jones", "Jessica Morgan", "Lisa King", "Patrick Diaz", "Betty Cook", "Nicholas James", "Rachel Scott", "Cheryl Collins", "Ernest Harris", "Tammy Griffin", "Wayne Miller", "Kenneth Watson", "Charles Gonzalez", "Anne Powell", "Brandon Bryant", "Katherine Robinson", "Marilyn Kelly", "Ruby Ramirez", "Melissa Ward", "Stephanie Howard", "Debra Barnes", "Jacqueline Sanders", "Roger Thompson", "Nancy Johnson", "Gregory Ross", "Diane Alexander", "Barbara Thomas", "Matthew Bennett", "Eric Young", "Raymond Taylor", "Tina Butler", "Carol Bell", "Jeffrey Wood", "Howard Cox", "Ronald Sanchez", "Nicole Lopez", "Jennifer Washington", "Michael Mitchell", "Ralph Moore", "Denise Martinez", "Susan Carter", "Gloria Roberts", "Benjamin Walker", "Amy Williams", "Randy Lewis", "Eugene Jenkins", "Victor Morris", "Margaret Anderson", "Steve Hill", "Todd Richardson", "Jerry Rivera", "Norma Flores", "Amanda Torres", "Jeremy Smith", "Christine Cooper", "Lillian Evans", "Jack Brooks", "Joshua Adams", "Douglas Patterson", "Henry Hughes", "Sarah Jackson", "Donna Wilson", "Maria Gray", "Cynthia Perry", "Bruce Davis", "Julia Price", "Brian Phillips", "Jimmy Murphy", "Ann"]
   Library.each do |lib|
     for i in 1..rand(20..40)
       Survey.create(user_name: names.sample, user_role: roles.sample, library_id: lib.id)
     end
   end
end

desc 'Generate sample answer for surveys'
task generate_answers: :environment do
  Survey.each do |sur|
    Question.each do |q|
      random_min = rand(1..8)
      random_per = rand(1..9)
      random_des = rand(random_min..9)
      Answer.create(survey_id: sur.id, question_id: q.id, min_score: random_min, per_score: random_per, des_score: random_des)
    end
  end
end
