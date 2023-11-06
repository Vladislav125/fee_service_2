class User < ApplicationRecord
  validates :login, uniqueness: true
  validates :firstname, presence: true
  validates :surname, presence: true
  validates :borndate, presence: true
  validates :address, presence: true
  validates :passport, presence: true

end
