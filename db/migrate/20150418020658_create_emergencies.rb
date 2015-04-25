class CreateEmergencies < ActiveRecord::Migration
  def change
    create_table :emergencies do |t|
      t.string :code, null: false
      t.integer :fire_severity, :police_severity, :medical_severity, null: false
      t.datetime :resolved_at
      t.boolean :full_response, default: false
      t.timestamps
    end
  end
end
