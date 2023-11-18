class User < ApplicationRecord
  attr_accessor :remember_token
  
  validates :surname, presence: true,
                      length: { maximum: 50 }
  validates :firstname, presence: true,
                      length: { maximum: 50 }
  validates :middlename, presence: true,
                      length: { maximum: 50 }
  VALID_BORN_DATE_REGEX = /\A\w\w.\w\w.\w\w\w\w\z/i
  validates :born_date, format: { with: VALID_BORN_DATE_REGEX }
  validates :address, presence: true,
                      length: { maximum: 100 }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true
end
