class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_many :ratings
  has_many :beers, through: :ratings, dependent: :destroy

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 30 }

  validates :password, format: { with: /\A(?=.*[A-Z])(?=.*[0-9]).{4,}\z/,
                                 message: "must contain at least four letters, one uppercase letter, and a digit" }

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    # TODO
    ratings.order(score: :desc).limit(1).first.beer.style
    # ratings.group_by{ |r| r.beer.style }.first.last.beer.style
  end
end
