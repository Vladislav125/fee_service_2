class User < ApplicationRecord
  validates :login, uniqueness: true
  validates :firstname, presence: true
  validates :surname, presence: true
  validates :born_date, presence: true
  validates :address, presence: true
  validates :passport, presence: true

  has_many :organizations
  has_many :vehicles
  has_many :estates
end
