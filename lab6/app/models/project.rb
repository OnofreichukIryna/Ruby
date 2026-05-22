class Project < ApplicationRecord
  # 1. Асоціації (зв'язки з іншими таблицями)
  belongs_to :category
  has_many :team_members, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # 2. Переліки (enums)
  enum :status, { planned: 0, in_progress: 1, completed: 2, cancelled: 3 }

  # 3. Валідації
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :budget, numericality: { greater_than_or_equal_to: 0 }
  validates :deadline, presence: true
  validate :deadline_after_start_date

  # 4. Скоупи (scopes)
  # два scopes по status
  scope :active_projects, -> { where(status: "in_progress") }
  scope :completed_projects, -> { where(status: "completed") }

  # проєкти з великим бюджетом
  scope :high_budget, -> { where("budget > ?", 10000) }

  # дедлайн у наступні 7 днів
  scope :deadline_soon, -> { where(deadline: Date.current..(Date.current + 7.days)) }

  private

  # Кастомний метод валідації дат
  def deadline_after_start_date
    return if deadline.blank? || start_date.blank?

    if deadline <= start_date
      errors.add(:deadline, "має бути пізніше за дату початку")
    end
  end
end
