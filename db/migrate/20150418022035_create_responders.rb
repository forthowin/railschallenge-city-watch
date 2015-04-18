class CreateResponders < ActiveRecord::Migration
  def change
    create_table :responders do |t|
      t.string :type, :name
      t.integer :capacity
    end
  end
end
