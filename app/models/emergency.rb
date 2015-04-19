class Emergency < ActiveRecord::Base
  validates_absence_of :id, message: 'found unpermitted parameter: id', on: :create
  validates_absence_of :resolved_at, message: 'found unpermitted parameter: resolved_at', on: :create

  validates :code, presence: true, uniqueness: { message: 'has already been taken' }
  validates :fire_severity, presence: true, numericality: { only_integer: true, message: 'is not a number' }
  validates :police_severity, presence: true, numericality: { only_integer: true, message: 'is not a number' }
  validates :medical_severity, presence: true, numericality: { only_integer: true, message: 'is not a number' }

  validates :fire_severity, numericality: { greater_than_or_equal_to: 0,
                                            message: 'must be greater than or equal to 0',
                                            if: 'fire_severity.is_a?(Numeric)' }
  validates :police_severity, numericality: { greater_than_or_equal_to: 0,
                                              message: 'must be greater than or equal to 0',
                                              if: 'police_severity.is_a?(Numeric)' }
  validates :medical_severity, numericality: { greater_than_or_equal_to: 0,
                                               message: 'must be greater than or equal to 0',
                                               if: 'medical_severity.is_a?(Numeric)' }
end
