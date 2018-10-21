class AddStyleToBeers < ActiveRecord::Migration[5.2]
  def change
    add_column :beers, :style_id, :integer
  end
end
