class User < ApplicationRecord
  attr_accessor :remember_token
  before_create :set_inn
  
  validates :inn, presence: true,
                  uniqueness: true
  VALID_PASSPORT_REGEX = /\A[1-9]\d{3} \d{6}\z/
  validates :passport, presence: { message: "Поле Паспорт не может быть пустым." },
                       uniqueness: { message: "Пользователь с таким паспортом уже зарегистрирован." },
                       format: { with: VALID_PASSPORT_REGEX, 
                                 message: "Паспорт должен соответствовать шаблону: 0000 000000." }
  VALID_SURNAME_REGEX = /\A[А-Я][а-я]*(-[А-Я][а-я]*)*\z/
  validates :surname, presence: { message: "Поле Фамилия не может быть пустым." },
                      length: { maximum: 50, 
                                message: "Поле Фамилия может содержать не более 50 символов." },
                      format: { with: VALID_SURNAME_REGEX, 
                                message: "Поле Фамилия введено некорректно." }
  VALID_FIRSTNAME_REGEX = /\A[А-Я][а-я]*\z/
  validates :firstname, presence: { message: "Поле Имя не может быть пустым." },
                        length: { maximum: 50, 
                                  message: "Поле Имя может содержать не более 50 символов." },
                        format: { with: VALID_FIRSTNAME_REGEX, 
                                  message: "Поле Имя введено некорректно." }
  VALID_MIDDLENAME_REGEX = /\A([А-Я][а-я]*)*\z/
  validates :middlename, length: { maximum: 50, 
                                   message: "Поле Отчество может содержать не более 50 символов." },
                         format: { with: VALID_MIDDLENAME_REGEX, 
                                   message: "Поле Отчество введено некорректно." }
  validates :born_date, presence: { message: "Поле Дата рождения не может быть пустым." }
  validates :address, presence: { message: "Поле Место жительства не может быть пустым." },
                      length: { maximum: 100, 
                                message: "Поле Место жительства может содержать не более 100 символов." }
  has_secure_password
  validates :password, length: { minimum: 8, 
                                 maximum: 100, 
                                 too_short: "Минимальная длина пароля: 8 символов.", 
                                 too_long: "Максимальная длина пароля: 100." }

  # возвращает случайный токен
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # запоминает пользователя в базе данных для использования в постоянных сеансах
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # возвращает true, если указанный дайджест соответствует токену
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)   
  end

  # забывает пользователя
  def forget
    update_attribute(:remember_digest, nil)
  end   

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
