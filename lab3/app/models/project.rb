class Project < ApplicationRecord
  enum :status, { planned: 0, in_progress: 1, completed: 2, cancelled: 3 }
end