class Project < ApplicationRecord
  belongs_to :category
  has_many :team_members, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  enum :status, { planned: 0, in_progress: 1, completed: 2, cancelled: 3 }

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :budget, numericality: { greater_than_or_equal_to: 0 }
  validates :deadline, presence: true
  validate :deadline_after_start_date

  scope :active_projects, -> { where(status: "in_progress") }
  scope :completed_projects, -> { where(status: "completed") }

  scope :high_budget, -> { where("budget > ?", 10000) }

  scope :deadline_soon, -> { where(deadline: Date.current..(Date.current + 7.days)) }

  private

  def deadline_after_start_date
    return if deadline.blank? || start_date.blank?

    if deadline <= start_date
      errors.add(:deadline, "має бути пізніше за дату початку")
    end
  end
end
