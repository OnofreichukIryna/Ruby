class Category < ApplicationRecord
  has_many :projects, dependent: :nullify
  validates :name, presence: true, uniqueness: true
end