class CreateResponders < ActiveRecord::Migration
  def change
    create_table :responders do |t|
      t.string :type, :name, null: false
      t.string :emergency_code
      t.integer :capacity, null: false
      t.integer :emergency_id
      t.boolean :on_duty, default: false
      t.timestamps
    end
  end
end
