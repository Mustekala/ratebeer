class AddClosedToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :closed, :boolean
  end
end
