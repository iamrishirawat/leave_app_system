class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :lockable
         #:recoverable, :rememberable, :trackable, :confirmable
  has_many :leave_applications
  
  def applicant?
    role == "Applicant"
  end
  
  def approver?
    role == "Approver"
  end
  
  #validates :password, :allow_nil => true
  validates :first_name, :presence => true, :length => { :within => 1..25 }
  validates :last_name, :presence => true, :length => { :within => 1..25 }
end
