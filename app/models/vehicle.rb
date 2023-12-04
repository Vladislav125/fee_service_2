class Vehicle < ApplicationRecord
  before_create :set_tax

  VALID_VIN_REGEX = /\A[1-9]\d{16}\z/
  validates :vin, presence: { message: "Поле Уникальный идентификатор транспортного соедства не может быть пустым." },
                  uniqueness: { message: "Это транспортное средство уже зарегистрировано." },
                  format: { with: VALID_VIN_REGEX, message: "Поле Уникальный идентификатор транспортного соедства заполнено некорректно." }
  VALID_STATE_NUMBER_REGEX = /\A[авенкморстух]\d{3}[авенкморстух]{2}(\d{2}|\d{3})\z/
  validates :state_number, presence: { message: "Поле Государственный регистрационный номер не может быть пустым." },
                           uniqueness: { message: "Транспортное средство с таким номерным знаком уже зарегистрировано." },
                           format: { with: VALID_STATE_NUMBER_REGEX, 
                                     message: "Номерной знак должен быть написан кириллицей и соответствовать шаблону: а000аа00." }
  validates :model, presence: { message: "Поле Модель транспортного средства не может быть пустым." }
  VALID_POWER_REGEX = /\A[1-9]\d*\z/
  validates :power, presence: { message: "Поле Мощность не может быть пустым." },
                    format: { with: VALID_POWER_REGEX, message: "Поле Мощность заполнено некорректно." }
  VALID_VEHICLE_TYPE_REGEX = /\A(мотоцикл)|(квадрицикл)|(легковой автомобиль)|(автобус)|(грузовой автомобиль)\z/
  validates :vehicle_type, presence: { message: "Поле Тип транспортного средсва не может быть пустым." },
                           format: { with: VALID_VEHICLE_TYPE_REGEX,
                                     message: "Такого типа транспортного средства не существует." }

  private

    def set_tax
      tax_base = 0
      case vehicle_type
        when 'мотоцикл'
          case power
            when (..19) then tax_base = 7
            when (20..35) then tax_base = 15
            when (36..) then tax_base = 50
          end
        when 'квадрицикл'
          case power
            when (..50) then tax_base = 25
            when (51..) then tax_base = 50 
          end
        when 'легковой автомобиль'
          case power
            when (..100) then tax_base = 12
            when (101..125) then tax_base = 25
            when (126..150) then tax_base = 35
            when (151..175) then tax_base = 45
            when (176..200) then tax_base = 50
            when (201..225) then tax_base = 65
            when (226..250) then tax_base = 75
            when (251..) then tax_base = 150
          end
        when 'автобус'
          case power
            when (..110) then tax_base = 15
            when (111..200) then tax_base = 26
            when (201..) then tax_base = 55
          end
        when 'грузовой автомобиль'
          case power
            when (..100) then tax_base = 15
            when (101..150) then tax_base = 26
            when (151..200) then tax_base = 38
            when (201..250) then tax_base = 55
            when (251..) then tax_base = 70
          end
      end
      # tax_time = 0
      # current_year = Time.now.year
      # ownnership = current_year - reg_date.year
      # case ownnership
      #   when (..0) then tax_time = 0
      #   when 1 then tax_time = 12 - reg_date.month
      #   when (2..) then tax_time = 12
      # end
      self.tax = power * tax_base
    end
end
