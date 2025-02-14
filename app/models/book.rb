class Book < ApplicationRecord
    def borrow(user)
      return false if borrowed?
      Borrowing.create(user: user, book: self, due_date: 2.weeks.from_now)
    end
  
    def return(user)
      borrowing = Borrowing.find_by(user: user, book: self)
      borrowing&.destroy
    end
  
    def borrowed?
      borrowings.exists?
    end
  end
  