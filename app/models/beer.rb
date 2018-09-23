class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  validates :name, presence: true

  def average
    return 0 if ratings.empty?

    ratings.map{ |r| r.score }.sum / ratings.count.to_f
  end

  def to_s
    name.to_s + ", panimo #{brewery.name}"
  end
end
