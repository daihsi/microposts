class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  MAX_DIGIT = 8
  MAX_NUMBER = 9

  def id_numbering
    id = MAX_DIGIT.times.map { rand(MAX_NUMBER) }.join
  end
end
