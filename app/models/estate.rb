class Estate < ApplicationRecord
  before_create :set_tax

  VALID_CADASTRAL_NUMBER_REGEX = /\A(\d{2}:){2}\d{6}:\d{2}\z/
  validates :cadastral_number, presence: { message: "Поле Кадастровый номер не может быть пустым." },
                               uniqueness: { message: "Недвижимость с таким кадастровым номером уже зарегистрирована." },
                               format: { with: VALID_CADASTRAL_NUMBER_REGEX, 
                                         message: "Кадастровый номер не соответствует шаблону: 00:00:000000:00." }
  VALID_NUMBER_REGEX = /\A[1-9]\d*\z/
  validates :square, presence: { message: "Поле Площадь не может быть пустым." },
                     format: { with: VALID_NUMBER_REGEX, 
                               message: "Поле Площадь заполнено некорректно." }
  validates :address, presence: { message: "Поле Адрес не может быть пустым." },
                      uniqueness: { message: "Недвижимость по этому адресу уже зарегистрирована." }
  validates :cost, presence: { message: "Поле Стоимость не может быть пустым." },
                   format: { with: VALID_NUMBER_REGEX, 
                             message: "Поле Стоимость заполнено некорректно." }
  VALID_TYPE_REGEX = /\A(земля)|(жилое помещение)|(нежилое помещение)\z/
  validates :estate_type, presence: { message: "Поле Тип недвижимости не может быть пустым." },
                   format: { with: VALID_TYPE_REGEX, 
                             message: "Такого типа недвижимости не существует." }

  private

    def set_tax
      temp_square = 0
      tax_base = 0
      if (self.estate_type == 'жилое помещение')
        if (self.square > 20)
          temp_square = self.square - 20
        else
          temp_square = 1
        end
        case self.cost
          when (..10_000_000)
            tax_base = self.cost * 0.001
          when (10_000_001..20_000_000)
            tax_base = self.cost * 0.0015
          when (20_000_001..50_000_000)
            tax_base = self.cost * 0.002
          when (50_000_001..300_000_000)
            tax_base = self.cost * 0.003
          when (300_000_001..)
            tax_base = self.cost * 0.02 
        end
      else
        tax_base = self.cost * 0.005
      end
      self.tax = tax_base
    end
end
