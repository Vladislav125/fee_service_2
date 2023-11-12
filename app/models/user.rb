class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  validates :login, uniqueness: true
  validates :firstname, presence: { is: true, message: "Поле не должно быть пустым" }
  validates :surname, presence: true
  validates :borndate, presence: true
  validates :address, presence: true
  validates :passport, presence: true

  has_many :organizations
  has_many :vehicles
  has_many :estates
end
