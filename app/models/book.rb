class Book < ApplicationRecord
    has_many :borrowings
    has_many :users, through: :borrowings
  
    # Check if the book is borrowed
    def borrowed?
      self.borrowed
    end
  end
  