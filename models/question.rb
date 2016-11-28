class Question < Sequel::Model
  QUESTIONS = [
    "What is the degree in which you usually find what you are looking for?",
    "What is the coverage degree about search topics?",
    "What is the degree of information electronic service about new inputs?",
    "What is the degree of variety of search tools?",
    "What is the navigability degree of the Website?",
    "What is the understandability degree of the Website?",
    "What is the degree of added value information profits?",
    "What is your satisfaction degree with the computing infrastructure?",
    "What is your satisfaction degree with the response time?",
    "What is the degree of training received?"
  ]
  class << self
    def initiate_data
      QUESTIONS.each do |q|
        Question.create(title: q)
      end
    end
  end

end
