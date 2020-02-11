class Question < ActiveRecord::Base
  has_many :players_questions
  has_many :players, through: :players_questions
end

=begin
#READ a question from appropriate category
def read_question(category)
    options = Question.where(category_num: category)
    question = options.sample
    q = question.question
    choices = question.choices
    options.reject { |i| i == question.id }
    prompt = TTY::Prompt.new
    choice = prompt.select(q) do |menu|
      menu.enum "."
  
      menu.choice "#{choices[0]}"
      menu.choice "#{choices[1]}"
      menu.choice "#{choices[2]}"
      menu.choice "#{choices[3]}"
    end
  end
=end
