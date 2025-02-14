class ProfilesController < ApplicationController
    before_action :authenticate_user!  # Protect this action
  
    def show
      borrowings = current_user.borrowings.where(returned: false).includes(:book)
      
      render json: { 
        user: current_user, 
        borrowed_books: borrowings.map { |b| { title: b.book.title, due_date: b.due_date } } 
      }
    end
  end
  