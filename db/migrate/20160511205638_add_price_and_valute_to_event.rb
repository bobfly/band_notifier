class AddPriceAndValuteToEvent < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :price, :decimal, precision: 2
  	add_column :events, :valute, :string, default: "EUR"
  end
end
