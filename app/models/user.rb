class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:omniauthable,
         :recoverable, :rememberable, :trackable, :validatable


  belongs_to :role
  has_many :favorites
  has_many :comments


  has_attached_file :avatar, :styles => { :medium => "300x300>", :samll=>"100x100>", :thumb => "100x100>" }
  has_attached_file :cover_photo, :styles => { :medium => "300x300>", :samll=>"100x100>", :thumb => "100x100>" }




  validates :name, :presence =>true
  validates :email, :presence => true
  validates :password, :presence => {:on => :create}, :confirmation =>true

  def to_s
    name
  end

end

