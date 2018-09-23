class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings
  has_many :beers, through: :ratings

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 30 }

  validates :password, format: { with: /\A(?=.*[A-Z])(?=.*[0-9]).{4,}\z/,
                                 message: "must contain at least four letters, one uppercase letter, and a digit" }
    
end
