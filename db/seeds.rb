users = 400             # jos koneesi on hidas, riittää esim 200
breweries = 200         # jos koneesi on hidas, riittää esim 100
beers_in_brewery = 50
ratings_per_user = 30

(1..users).each do |i|
  User.create! username: "user_#{i}", password:"Passwd1", password_confirmation: "Passwd1"
end

(1..breweries).each do |i|
  Brewery.create! name:"Brewery_#{i}", year: 1900, active: true
end

bulk = Style.create! name: "Bulk", description: "cheap, not much taste"

Brewery.all.each do |b|
  n = rand(beers_in_brewery)
  (1..n).each do |i|
    beer = Beer.create name:"Beer #{b.id} -- #{i}", style:bulk
    b.beers << beer
  end
end

User.all.each do |u|
  n = rand(ratings_per_user)
  beers = Beer.all.shuffle
  (1..n).each do |i|
    r = Rating.new score:(1+rand(50))
    beers[i].ratings << r
    u.ratings << r
  end
end