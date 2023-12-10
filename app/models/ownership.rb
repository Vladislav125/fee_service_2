class Ownership < ApplicationRecord
  validates :reg_date, presence: { message: "Поле Дата начала периода владения не может быть пустым." }
  validates :end_date, presence: { message: "Поле Дата окончания периода владения не может быть пустым." }
  validate :period_must_be_unique

  private

    def period_must_be_unique
      unless period_is_unique?
        errors.add(:reg_date, "Владение этим имуществом в этот период уже зарегистрироавно. Периоды владения не могут пересекаться.")
      end
    end

    def period_is_unique?
      if self.vehicle_id != nil
        @ownerships = Ownership.where(vehicle_id: self.vehicle_id)
      elsif self.estate_id != nil
        @ownerships = Ownership.where(estate_id: self.estate_id)
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
end