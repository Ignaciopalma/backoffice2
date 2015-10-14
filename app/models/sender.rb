class Sender < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
          :rememberable, :trackable, :validatable

  belongs_to :area
  belongs_to :city

  validates_inclusion_of :pay_day, :in => 1..31
end
