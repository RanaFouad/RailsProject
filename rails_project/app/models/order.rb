class Order < ActiveRecord::Base

	belongs_to :user
	has_many :order_details, :dependent => :delete_all
	has_many :invitations, :dependent => :delete_all

	attr_accessor :friends

	has_attached_file :menuimage, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :menuimage, :content_type => /\Aimage\/.*\Z/

  def index
  	
  end
  def show
  	@order = order.find(params[:id])
  end
end
