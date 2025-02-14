class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def borrow
    @book = Book.find(params[:id])
    if @book.borrow(current_user)
      redirect_to @book, notice: "Book borrowed successfully!"
    else
      redirect_to @book, alert: "Book is already borrowed."
    end
  end

  def return
    @book = Book.find(params[:id])
    if @book.return(current_user)
      redirect_to @book, notice: "Book returned successfully!"
    else
      redirect_to @book, alert: "You haven't borrowed this book."
    end
  end
end
