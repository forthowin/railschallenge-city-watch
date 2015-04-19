class CreateEmergencies < ActiveRecord::Migration
  def change
    create_table :emergencies do |t|
      t.string :code
      t.integer :fire_severity, :police_severity, :medical_severity
      t.datetime :resolved_at
    end
  end
end
