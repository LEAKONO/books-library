class ProfilesController < ApplicationController
    before_action :authenticate_user!  # Protect this action
  
    def show
      borrowings = @current_user.borrowings.where(returned: false).includes(:book)
      render json: { user: @current_user, borrowed_books: borrowings }
    end
  end
  