class UserValidator < ActiveModel::Validator
  @VALID_INCOME_REGEX = /\A0|([1-9]\d*)\z/
  @VALID_SNILS_REGEX = /\A(\d{3}-){3}\d{2}\z/
  @VALID_PASSPORT_REGEX = /\A[1-9]\d{3} \d{6}\z/
  @VALID_SURNAME_REGEX = /\A[А-Я][а-я]*(-[А-Я][а-я]*)*\z/
  @VALID_FIRSTNAME_REGEX = /\A[А-Я][а-я]*\z/
  @VALID_MIDDLENAME_REGEX = /\A([А-Я][а-я]*)*\z/
  @VALID_BALANCE_REGEX = /\A0|([1-9]\d*)\z/

  def validate(user)
    ApplicationRecord.validates :inn, uniqueness: true
    ApplicationRecord.validates :income, format: { with: @VALID_INCOME_REGEX, message: "Некорректно заполнено поле доход." }
    ApplicationRecord.validates :password, presence: { message: "Поле Пароль не может быть пустым." },
                       length: { minimum: 8, 
                                 maximum: 100, 
                                 too_short: "Минимальная длина пароля: 8 символов.", 
                                 too_long: "Максимальная длина пароля: 100." }
    ApplicationRecord.validates :password_confirmation, presence: { message: "Поле Подтверждение пароля не может быть пустым." }
    ApplicationRecord.validates :balance, format: { with: @VALID_BALANCE_REGEX, message: "Поле Сумма пополнения введено некорректно." }
 
    if user.organization?
      ApplicationRecord.validates :snils, :passport, :surname, :middlename, absence: { message: "Поля СНИЛС, Паспорт, Фамилия, Отчество недопустимы для данного пользователя." }
      ApplicationRecord.validates :firstname, presence: { message: "Поле Наименование не может быть пустым." },
                            length: { maximum: 100, 
                                      message: "Поле Наименование может содержать не более 100 символов." }
      ApplicationRecord.validates :born_date, presence: { message: "Поле Дата регистрации не может быть пустым." }
      ApplicationRecord.validates :address, presence: { message: "Поле Адрес регистрации не может быть пустым." },
                          length: { maximum: 100, 
                                    message: "Поле Адрес регистрации может содержать не более 100 символов." }
    else
      ApplicationRecord.validates :snils, presence: { message: "Поле СНИЛС не может быть пустым." },
                        uniqueness: { message: "Пользователь с таким СНИЛС уже зарегистрирован." },
                        format: { with: @VALID_SNILS_REGEX, 
                                  message: "Формат СНИЛС не соответствует: 000-000-000-00." }
                                  ApplicationRecord.validates :passport, presence: { message: "Поле Паспорт не может быть пустым." },
                          uniqueness: { message: "Пользователь с таким паспортом уже зарегистрирован." },
                          format: { with: @VALID_PASSPORT_REGEX, 
                                    message: "Паспорт должен соответствовать шаблону: 0000 000000." }
      ApplicationRecord.validates :surname, presence: { message: "Поле Фамилия не может быть пустым." },
                          length: { maximum: 50, 
                                    message: "Поле Фамилия может содержать не более 50 символов." },
                          format: { with: @VALID_SURNAME_REGEX, 
                                    message: "Поле Фамилия введено некорректно." }
      ApplicationRecord.validates :firstname, presence: { message: "Поле Имя не может быть пустым." },
                            length: { maximum: 50, 
                                      message: "Поле Имя может содержать не более 50 символов." },
                            format: { with: @VALID_FIRSTNAME_REGEX, 
                                      message: "Поле Имя введено некорректно." }
      ApplicationRecord.validates :middlename, length: { maximum: 50, 
                                      message: "Поле Отчество может содержать не более 50 символов." },
                            format: { with: @VALID_MIDDLENAME_REGEX, 
                                      message: "Поле Отчество введено некорректно." }
      ApplicationRecord.validates :born_date, presence: { message: "Поле Дата рождения не может быть пустым." }
      ApplicationRecord.validates :address, presence: { message: "Поле Место жительства не может быть пустым." },
                          length: { maximum: 100, 
                                    message: "Поле Место жительства может содержать не более 100 символов." }
    end
  end
end

class User < ApplicationRecord
  attr_accessor :remember_token
  before_create :set_inn
  before_create :set_kpp
  
  validates_with UserValidator

  has_secure_password
  has_many_attached :files

  paginates_per 10

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

  def full_name
    full_name = ""
    if self.organization
      full_name = firstname
    else
      full_name = surname + ' ' + firstname
      if !middlename.empty?
        full_name += ' ' + middlename
      end
    end
    full_name
  end

  def generate_ipid
    if ipid == nil
      loop do
        temp_ipid = rand(1..9).to_s
        14.times { temp_ipid += rand(0..9).to_s }
        if User.find_by(ipid: temp_ipid) == nil
          self.update_column(:ipid, temp_ipid)
          break
        end
      end 
    end
  end

  private

    # Присваивание ИНН
    def set_inn
      length = 11
      if organization? 
        length = 9
      end
      loop do
        temp_inn = rand(1..9).to_s
        length.times { temp_inn += rand(0..9).to_s }
        if User.find_by(inn: temp_inn) == nil
          self.inn = temp_inn
          break
        end
      end
    end

    # Присваивание КПП
    def set_kpp
      if organization?
        loop do
          temp_org_kpp = rand(1..9).to_s
          8.times { temp_org_kpp += rand(0..9).to_s }
          if User.find_by(kpp: temp_org_kpp) == nil
            self.kpp = temp_org_kpp
            break
          end
        end
      else
        self.kpp = nil
      end
    end
end
