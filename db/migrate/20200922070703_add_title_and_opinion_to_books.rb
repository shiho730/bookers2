class AddTitleAndOpinionToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :title, :string
    add_column :books, :body, :string
  end
end
