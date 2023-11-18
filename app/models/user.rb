class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :set_inn
  
  validates :inn, presence: true,
                  uniqueness: true
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

  private

    # Присваивание ИНН
    def set_inn
      loop do
        temp_inn = rand(1..9).to_s
        11.times { temp_inn += rand(0..9).to_s }
        self.inn = temp_inn
        break if valid?
      end
    end
end
