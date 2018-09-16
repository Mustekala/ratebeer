class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating
    #TODO paremmin
    sum = 0
    ratings.each do |rating|
      sum += rating.score
    end
    sum / ratings.count
  end

  def to_s
    "#{name}" + ", panimo #{brewery.name}"
  end 
end
