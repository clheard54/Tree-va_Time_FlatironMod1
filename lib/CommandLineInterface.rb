class CommandLineInterface
  def greet
    puts "Welcome to Treee-va Time!"
  end

  def select_category
    require "tty-prompt"
    prompt = TTY::Prompt.new
    choice = prompt.select("Pick your poison: Select the category from which you'd like to answer a question:") do |menu|
      menu.enum "."

      menu.choice "Books"
      menu.choice "Films"
      menu.choice "Science"
      menu.choice "Mythology"
      menu.choice "Sports"
      menu.choice "Geography"
      menu.choice "History"
      menu.choice "Art"
      menu.choice "Celebrities"
      menu.choice "Animals"
    end

    puts "You've chosen #{choice}. Ready? (yes/no)"
    command = gets.strip
    case command.downcase
    when "yes"
      #run the API method
      choice
    when "no"
      self.select_category
    end
  end

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

  def get_question
    category = self.select_category
    puts "Here we go. As you requested, a question about #{category}."
    category_num = { "Books": 10, "Science": 17, "Film": 11, "Mythology": 20, "Sports": 21, "Geography": 22, "History": 23, "Art": 25, "Celebrities": 26, "Animals": 27 }
    x = category_num[category]
    read_question(x)
  end
end
