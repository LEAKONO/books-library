class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:borrow, :return_book, :create]  # Protect the create action

  def index
    books = Book.all
    render json: books, status: :ok
  end

  def show
    render json: @book
  end

  def create
    book = Book.new(book_params)

    if book.save
      render json: { message: 'Book created successfully', book: book }, status: :created
    else
      render json: { error: 'Failed to create book', details: book.errors.full_messages }, status: :unprocessable_entity
    end
  end

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

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn)  # Only allow the necessary fields
  end
end
