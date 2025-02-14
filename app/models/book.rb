class Book < ApplicationRecord
    has_many :borrowings
    has_many :users, through: :borrowings
  
    validates :title, presence: true
    validates :author, presence: true
    validates :isbn, presence: true, uniqueness: true
  end
  