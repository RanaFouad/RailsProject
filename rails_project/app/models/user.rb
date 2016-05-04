class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :orders, :dependent => :delete_all 
  has_many :order_details, :dependent => :delete_all
  has_many :invitations, :dependent => :delete_all
  has_many :groups, :dependent => :delete_all
  has_many :group_members, :dependent => :delete_all
  has_many :friendships, :dependent => :delete_all
  has_many :friends, :through => :friendships

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable 
         validates_confirmation_of :password

  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "50x50#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/ 

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.username = auth.info.username
        user.password = Devise.friendly_token[0,20]
      end
  end      

end
