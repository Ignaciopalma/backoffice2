class Sender < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
          :rememberable, :trackable, :validatable



  belongs_to :area
  belongs_to :city
  has_many :deliveries

  validates_inclusion_of :pay_day, :in => 1..31
end
