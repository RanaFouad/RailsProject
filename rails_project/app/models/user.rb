class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :orders, :dependent => :delete_all 
  has_many :order_details, :dependent => :delete_all
  has_many :invitations, :dependent => :delete_all
  has_many :groups, :dependent => :delete_all
  has_many :group_members, :dependent => :delete_all
  has_many :friends, :dependent => :delete_all

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/       
end
