class CommandLineInterface
  def greet
    puts "Welcome to Treee-va Time!"
  end

  def create_player
    require "tty-prompt"
    prompt = TTY::Prompt.new
    name = prompt.ask("First: What is your name?", default: ENV["Player1"])
    @player = Player.create(name: name)
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

  def read_question(new_question)
    @q = new_question.question
    @choices = new_question.choices
    prompt = TTY::Prompt.new
    choice = prompt.select(@q) do |menu|
      menu.choice '#{@choices[0]}', "a"
      menu.choice '#{@choices[1]}', "b"
      menu.choice '#{@choices[2]}', "c"
      menu.choice '#{@choices[3]}', "d"
    end
    current_q = PlayersQuestion.find_by(player_id: self.id, question_id: new_question.id)
    current_q.update(chosen_answer: choice)
  end

  def get_question
    category = self.select_category
    puts "Here we go. As you requested, a question about #{category}."
    category_num = { "Books": 10, "Science": 17, "Film": 11, "Mythology": 20, "Sports": 21, "Geography": 22, "History": 23, "Art": 25, "Celebrities": 26, "Animals": 27 }
    x = category_num[category]
    options = Question.where(category_num: x)
    new_question = options.sample
    PlayersQuestion.new(player_id: self.id, question_id: new_question.id)
    options.reject { |i| i == new_question.id }
    read_question(new_question)
  end

  def break
    require "tty-prompt"
    prompt = TTY::Prompt.new
    next_move = prompt.select("Whew. One down. What's your nexdt move?") do |menu|
      menu.enum "."

      menu.choice "WAIT GO BACK I WANT TO CHANGE MY ANSWER!", 1
      menu.choice "I'm in a groove. Give me another question.", 2
      menu.choice "Brain hurts. Just tell me my score.", 3
    end
    next_move
  end

  def calculate(answered)
    dividend = answered.length
    divisor = 0
    answered.each do |player_question|
      rel_q = Question.find_by(id: player_question.question_id)
      if player_question.chosen_answer == rel_q.correct_answer
        divisor += 1
      end
    end
    score = 100 * ((divisor / dividend).to_f)
    if score < 55
      puts "Oof. Study up."
    elsif score < 85
      puts "All right, all right, I see you. Nicely done."
    else
      puts "I salute you, professor! You are indeed a trivia master!"
    end
    puts "You scored a #{score}%. Good game."
  end
end
