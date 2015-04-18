class Emergency < ActiveRecord::Base
  validates_numericality_of :fire_severity, greater_than: 0, message: 'must be greater than or equal to 0'
  validates_numericality_of :police_severity, greater_than: 0, message: 'must be greater than or equal to 0'
  validates_numericality_of :medical_severity, greater_than: 0, message: 'must be greater than or equal to 0'
end