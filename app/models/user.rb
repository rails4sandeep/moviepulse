class User < ActiveRecord::Base
  has_many :reviews
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  #:confirmable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
                  :username, :age, :sex, :city, :country
  # attr_accessible :title, :body
  scope :user_details,lambda {|id| where(:user_id => id)}

  #validations
  validates_presence_of :username,:age,:sex,:city,:country, :message => "can't be blank"
  
  
end
