namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'

  Vehicle.delete_all
  Event.delete_all
  Role.delete_all

  Role.create(:name =>'admin')
  Role.create(:name =>'user')
  ['car','truk','wagon','hybird','sport','suv'].each do |x|
    Category.create(:name => x)
  end
    Event.populate 30 do |e|
      e.name        = Faker::Lorem.words(5..8)
      e.note        = Faker::Lorem.paragraphs(2)
      e.description = Faker::Lorem.paragraphs(2..8)
      e.s_date      = Time.now + [1,2,3,4,5].sample.days
      e.e_date      = Time.now + [5,6,7,8,9].sample.days
      e.location    = ['us','ua','changepond', 'kanchi','chennai','india'].sample

    end


    Vehicle.populate 30 do |v|
      v.title       = Faker::Lorem.words(5..8)
      v.note        = Faker::Lorem.paragraphs(2..3)
      v.description = Faker::Lorem.paragraphs(2..8)
      v.v_type        = ['car','truk', 'hybird','sport','suv','wegon','others'].sample
      v.condition   = ['new','used'].sample
      v.location    = ['us','ua','india','uk','uae'].sample
      v.price       = ['100000','250000','500000','600000','300000'].sample
      v.vin         = ['m123','w2500','as23432','d009988','s009988','s998877'].sample
      #v.avatar      = 'car.png'
      a = []
      Category.all.each{|s|a << s.id}
      v.category_id = a.sample
      v.status      = ['sale','rent'].sample
      v.active      = true
    end
  end
end
