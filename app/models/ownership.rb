class Ownership < ApplicationRecord
  before_create :set_tax_sum

  validates :reg_date, presence: { message: "Поле Дата начала периода владения не может быть пустым." }
  validates :end_date, presence: { message: "Поле Дата окончания периода владения не может быть пустым." }
  validate :period_must_be_unique
  validate :dates_have_same_years

  private

    def set_tax_sum
      tax_time = (end_date.year * 12 + end_date.month) - (reg_date.year * 12 + reg_date.month)
      if (end_date.day - reg_date.day) > 15
        tax_time += 1
      end
      if self.vehicle_id != nil
        object = Vehicle.find(self.vehicle_id)
      elsif self.estate_id != nil
        object = Estate.find(self.estate_id)
      else
        object = nil
      end
      if self.vehicle_id == nil && self.estate_id == nil
        self.tax_sum = self.income * 0.13
      else
        self.tax_sum = object.tax * tax_time / 12
      end
    end

    def period_must_be_unique
      unless period_is_unique?
        errors.add(:reg_date, "Такой период налообложения уже зарегистрирован для данного объекта.")
      end
    end

    def period_is_unique?
      if self.vehicle_id != nil
        @ownerships = Ownership.where(vehicle_id: self.vehicle_id)
      elsif self.estate_id != nil
        @ownerships = Ownership.where(estate_id: self.estate_id)
      else
        @ownerships = Ownership.where(user_id: self.user_id)
      end
      result = true
      if @ownerships != nil
        @ownerships.each do |period|
          result &&= periods_do_not_intersect?(self.reg_date, self.end_date, period.reg_date, period.end_date)
        end
      end
      result
    end

    def periods_do_not_intersect?(start1, end1, start2, end2)
      return end1 < start2 || start1 > end2
    end

    def dates_have_same_years
      unless self.reg_date.year == self.end_date.year
        errors.add(:reg_date, "Год даты начала периода должен совпадать с годом конца периода..")
      end
    end
end