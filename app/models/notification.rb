class Notification < ApplicationRecord
  belongs_to :user
  before_create :set_preview

  validates :text_field, presence: { message: "Поле Текст уведомления не может быть пустым." }

  private

    def set_preview
      temp = ""
      if self.text_field.length > 30
        temp = self.text_field.slice(0..29)
        temp += "..."
        self.preview = temp
      else
        self.preview = self.text_field
      end
    end
end
