class Organization < ApplicationRecord
  belongs_to :user
  before_create :set_org_inn
  before_create :set_org_kpp

  validates :name, presence: { message: "Поле Наименование организации не может быть пустым." }
  validates :address, presence: { message: "Поле Адрес организации не может быть пустым." },
                      uniqueness: { message: "Организация с таким адресом уже зарегистрирована." }
  VALID_INCOME_REGEX = /\A[1-9]\d*\z/                   
  validates :income, presence: { message: "Поле Доход организации не может быть пустым." },
                     format: { with: VALID_INCOME_REGEX,
                               message: "Поле Доход организации заполнено некорректно." }
  validates :reg_date, presence: { message: "Поле Дата регистрации не может быть пустым." }

  private

    def set_org_inn
      loop do
        temp_org_inn = rand(1..9).to_s
        9.times { temp_org_inn += rand(0..9).to_s }
        if Organization.find_by(org_inn: temp_org_inn) == nil
          self.org_inn = temp_org_inn
          break
        end
      end
    end

    def set_org_kpp
      loop do
        temp_org_kpp = rand(1..9).to_s
        8.times { temp_org_kpp += rand(0..9).to_s }
        if Organization.find_by(org_kpp: temp_org_kpp) == nil
          self.org_kpp = temp_org_kpp
          break
        end
      end
    end
end
