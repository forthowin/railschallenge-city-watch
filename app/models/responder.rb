class Responder < ActiveRecord::Base
  belongs_to :emergency

  self.inheritance_column = :_type_disabled

  validates :capacity, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5,
                                                       message: 'is not included in the list' }, on: :create
  validates :name, presence: true, uniqueness: true, on: :create
  validates :type, presence: true

  scope :total_capacity,        ->(type) { where('type = ?', type) }
  scope :available,             ->(type) { where('type = ? AND emergency_code IS NULL', type) }
  scope :on_duty,               ->(type) { where('type = ? AND on_duty = ?', type, true) }
  scope :available_and_on_duty, ->(type) { where('type = ? AND on_duty = ? AND emergency_code IS NULL', type, true) }
  scope :capacity,              -> { sum('capacity') }
end
