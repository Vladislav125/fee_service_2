class Estate < ApplicationRecord
  belongs_to :user

  VALID_CADASTRAL_NUMBER_REGEX = /\A(\d{2}:){2}\d{6}:\d{2}\z/
  validates :cadastral_number, presence: { message: "Поле Кадастровый номер не может быть пустым." },
                               uniqueness: { message: "Недвижимость с таким кадастровым номером уже зарегистрирована." },
                               format: { with: VALID_CADASTRAL_NUMBER_REGEX, message: "Кадастровый номер не соответствует шаблону: 00:00:000000:00." }
  VALID_NUMBER_REGEX = /\A[1-9]\d*\z/
  validates :square, presence: { message: "Поле Площадь не может быть пустым." },
                     format: { with: VALID_NUMBER_REGEX, message: "Поле Площадь заполнено некорректно." }
  validates :address, presence: { message: "Поле Адрес не может быть пустым." },
                      uniqueness: { message: "Недвижимость по этому адресу уже зарегистрирована." }
  validates :cost, presence: { message: "Поле Стоимость не может быть пустым." },
                   format: { with: VALID_NUMBER_REGEX, message: "Поле Стоимость заполнено некорректно." }
  VALID_TYPE_REGEX = /\A(земля)|(жилое помещение)|(нежилое помещение)\z/
  validates :estate_type, presence: { message: "Поле Тип недвижимости не может быть пустым." },
                   format: { with: VALID_TYPE_REGEX, message: "Такого типа недвижимости не существует." }
  validates :reg_date, presence: { message: "Поле Дата регистрации не может быть пустым." }
end
