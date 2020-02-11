emma = Player.create("Emma")
carol = Player.create("Carol")
jenny = Player.create("Jenny")

eliminate = Clue.create("Eliminate one option")
hint = Clue.create("Get a helpful hint")
random = Clue.create("Who knows what assistance you'll get?")

# one = Question.create("How many popes have there been?")
# two = Question.create("What is the most Oscar-decorated movie of all time?")
# three = Question.create("How many ridges does a dime have aruond its edge?")
# four = Question.create("How many states have capitals that begin with the same letter?")

def grab(category_number)
  url = "https://opentdb.com/api.php?amount=10&category=#{category_number}&difficulty=medium&type=multiple"
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  questions = JSON.parse(response.body)

  i = Random.rand(10)

  questions["results"][i]["incorrect_answers"] << questions["results"][i]["correct_answer"]
  answers = questions["results"][i]["incorrect_answers"]

  @question = questions["results"][i]["question"]
  @cat = category_number
  @choices = answers.shuffle
  @correct = questions["results"][i]["correct_answer"]

  Question.create(question: @question, category_num: @cat, choices: @choices, correct_answer: @correct)
end

categories = [10, 11, 17, 20, 21, 22, 23, 25, 26, 27]
categories.each do |num|
  grab(num)
end
