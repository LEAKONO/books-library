class BooksController < ApplicationController
  # Only protect borrow and return actions, allow book creation without auth
  before_action :authenticate_user!, only: [:borrow, :return_book]

  def index
    books = Book.all
    render json: books, status: :ok
  end

  def show
    book = Book.find_by(id: params[:id])  # Fetch by ID to avoid nil errors
    if book
      render json: book, status: :ok
    else
      render json: { error: 'Book not found' }, status: :not_found
    end
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
    Rails.logger.info "Params received: #{params.inspect}"
  
    book = Book.find_by(id: params[:book_id])  # Ensure book_id is used
  
    if book.nil?
      Rails.logger.error "Book not found"
      return render json: { error: 'Book not found' }, status: :not_found
    end
  
    if book.borrowed?
      Rails.logger.error "Book is already borrowed"
      return render json: { error: 'Book already borrowed' }, status: :unprocessable_entity
    end
  
    if current_user.nil?
      Rails.logger.error "Unauthorized access attempt"
      return render json: { error: 'Unauthorized user' }, status: :unauthorized
    end
  
    borrowing = Borrowing.new(
      book: book,
      user: current_user,
      due_date: 2.weeks.from_now,
      returned: false # Ensure `returned` field is included
    )
  
    if borrowing.save
      book.update(borrowed: true)
      Rails.logger.info "Borrowing record created successfully: #{borrowing.inspect}"
      render json: { message: 'Book borrowed successfully', borrowing: borrowing }, status: :ok
    else
      Rails.logger.error "Failed to create borrowing record: #{borrowing.errors.full_messages}"
      render json: { error: borrowing.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  

  def return_book
    book = Book.find_by(id: params[:book_id])  # Ensure correct param name
    
    if book.nil?
      render json: { error: 'Book not found' }, status: :not_found
      return
    end
  
    borrowing = Borrowing.find_by(book: book, user: current_user)
  
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
    params.require(:book).permit(:title, :author, :isbn)
  end
end
