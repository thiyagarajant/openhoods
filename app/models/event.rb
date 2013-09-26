class Event < ActiveRecord::Base
  has_attached_file :avatar, :styles => {:small => 'x50',:large => "1280x800>", :medium => "300x300>", :thumb => "100x100>" }
end
