class BooksController < ApplicationController
    before_action :authenticate_user!, only: [:borrow, :return_book]
  
    def borrow
      book = Book.find(params[:id])
      if book.borrowed?
        render json: { error: 'Book already borrowed' }, status: :unprocessable_entity
      else
        book.update(borrowed: true)
        Borrowing.create(book: book, user: @current_user, due_date: 2.weeks.from_now)
        render json: { message: 'Book borrowed successfully' }, status: :ok
      end
    end
  
    def return_book
      book = Book.find(params[:id])
      borrowing = Borrowing.find_by(book: book, user: @current_user)
      
      if borrowing.nil?
        render json: { error: 'You have not borrowed this book' }, status: :unprocessable_entity
      else
        borrowing.destroy
        book.update(borrowed: false)
        render json: { message: 'Book returned successfully' }, status: :ok
      end
    end
  end
  