class CreateResponders < ActiveRecord::Migration
  def change
    create_table :responders do |t|
      t.string :type, :name, :emergency_code
      t.integer :capacity
      t.boolean :on_duty, default: false
    end
  end
end
