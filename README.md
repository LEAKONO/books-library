# Book Lending Library (Ruby on Rails 8)

## Overview
This is a **Book Lending Library** built using **Ruby on Rails 8**. It allows users to register, browse books, borrow available books, and return them after a due period.

## Features
- **User Authentication** (Default Rails 8 authentication)
- **Book Listing** (Displays all books with availability status)
- **Book Details Page** (Shows more information and a borrow button)
- **User Profile** (Lists currently borrowed books)
- **Borrowing System**
  - Users can borrow books if available
  - Borrowing duration: **2 weeks**
  - Prevents borrowing of already borrowed books
- **Returning System**
  - Users can return borrowed books
- **Validations**
  - Title, author, and ISBN are required
  - ISBN must be unique
- **Error Handling**
  - Prevents borrowing if a book is unavailable
- **Testing**
  - Uses Rails' default testing framework
- **Deployment**
  - Hosted on GitHub with clear commit messages
  - Includes a setup guide

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/LEAKONO/books-library
   cd book_library
   ```

2. Install dependencies:
   ```sh
   bundle install
   ```

3. Setup the database:
   ```sh
   rails db:create db:migrate db:seed
   ```

4. Start the server:
   ```sh
   rails server
   ```

5. Open the app in your browser:
   ```
   http://localhost:3000
   ```

## Screenshots
![Screenshot ](https://github.com/LEAKONO/books-library/issues/1)



## API Endpoints
| Method | Endpoint | Description |
|--------|---------|-------------|
| GET    | `/books` | Fetch all books |
| GET    | `/books/:id` | Get details of a specific book |
| POST   | `/borrow/:book_id` | Borrow a book |
| POST   | `/return/:book_id` | Return a borrowed book |



## License
This project is licensed under the MIT License.

---
**Author:** Emmanuel Leakono

