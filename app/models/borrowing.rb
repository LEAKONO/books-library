class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :due_date, presence: true
  validates :returned, inclusion: { in: [true, false] }

  def overdue?
    !returned && due_date < Date.today
  end
end
