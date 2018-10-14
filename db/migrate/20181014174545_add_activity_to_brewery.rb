class AddActivityToBrewery < ActiveRecord::Migration[5.2]
  def change
    add_column :breweries, :active, :boolean
  end
end
