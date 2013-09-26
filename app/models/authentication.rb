class Authentication < ActiveRecord::Base
  belongs_to :user

  def self.fb_basic_info(param)
    user = User.new
    user.name = param[:name]
    user.email = param[:email]
    user.city  = param[:location]
    user
  end
end
