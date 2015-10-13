class Sender < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :recoverable,
  devise :database_authenticatable,
          :rememberable, :trackable, :validatable

  belongs_to :area
  belongs_to :city

  validates_inclusion_of :pay_day, :in => 0..31
end
