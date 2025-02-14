class AddBorrowedToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :borrowed, :boolean, default: false
  end
end
