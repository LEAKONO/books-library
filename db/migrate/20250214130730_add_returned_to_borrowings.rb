class AddReturnedToBorrowings < ActiveRecord::Migration[8.0]
  def change
    add_column :borrowings, :returned, :boolean
  end
end
