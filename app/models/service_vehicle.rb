class ServiceVehicle < ApplicationRecord
  class Vehicle < ApplicationRecord
    belongs_to :organization
  
    VALID_STATE_NUMBER_REGEX = /\A[авенкморстух]\d{3}[авенкморстух]{2}(\d{2}|\d{3})\z/
    validates :state_number, presence: { message: "Поле Государственный регистрационный номер не может быть пустым." },
                             uniqueness: { message: "Транспортное средство с таким номерным знаком уже зарегистрировано." },
                             format: { with: VALID_STATE_NUMBER_REGEX, 
                                       message: "Номерной знак должен быть написан кириллицей и соответствовать шаблону: а000аа00." }
    validates :model, presence: { message: "Поле Модель транспортного средства не может быть пустым." }
    VALID_POWER_REGEX = /\A[1-9]\d*\z/
    validates :power, presence: { message: "Поле Мощность не может быть пустым." },
                      format: { with: VALID_POWER_REGEX, message: "Поле Мощность заполнено некорректно." }
    VALID_VEHICLE_TYPE_REGEX = /\A(мопед)|(мотоцикл)|(квадрицикл)|(легковой автомобиль)|(автобус)|(грузовой автомобиль)|(прицеп)\z/
    validates :vehicle_type, presence: { message: "Поле Тип транспортного средсва не может быть пустым." },
                             format: { with: VALID_VEHICLE_TYPE_REGEX,
                                       message: "Такого типа транспортного средства не существует." }
    validates :reg_date, presence: { message: "Поле Дата регистрации не может быть пустым." }
  end
  
end
