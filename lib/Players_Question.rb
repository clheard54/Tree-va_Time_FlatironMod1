class Players_Question < ActiveRecord::Base
  has_many :players
  has_many :questions
end
