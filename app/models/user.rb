class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  has_many :favorites
  has_many :authentications
  has_many :videos

  has_attached_file :avatar, :styles => {:small => 'x50', :medium => "300x300>", :thumb => "100x100>" }#, :default_url => "thiyagu.png"
  has_attached_file :cover_photo, :styles => {:small => 'x50',:large =>"600x600",  :medium => "300x300>", :thumb => "100x100>" }#, :default_url => "thiyagu.png"

  validates :role,:name,:email, :city, :presence => true
  validates :password, presence: true, length: {minimum: 5, maximum: 120}, on: :create
  validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true

  def apply_omniauth(omni)
    authentications.build(:provider => omni['provider'],
    :uid => omni['uid'],
    :token => omni['credentials'].token,
    :token_secret => omni['credentials'].secret)
  end

  def to_s
    name
  end

end
