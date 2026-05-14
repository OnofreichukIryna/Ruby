class Project < ApplicationRecord
  enum :status, { planned: 0, in_progress: 1, completed: 2, cancelled: 3 }

  # два scopes по status
  scope :active_projects, -> { where(status: "in_progress") }
  scope :completed_projects, -> { where(status: "completed") }

  # проєкти з великим бюджетом
  scope :high_budget, -> { where("budget > ?", 10000) }

  # дедлайн у наступні 7 днів
  scope :deadline_soon, -> { where(deadline: Date.current..(Date.current + 7.days)) }
end
