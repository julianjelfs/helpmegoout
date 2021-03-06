class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :address, :phone
  # attr_accessible :title, :body
  
  has_many :request, :dependent => :destroy
  has_many :child, :dependent => :destroy
  has_and_belongs_to_many :circle
  
end
