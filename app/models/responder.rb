class Responder < ActiveRecord::Base
  belongs_to :emergency, foreign_key: :emergency_code, primary_key: :code

  self.inheritance_column = :_type_disabled

  validates :capacity, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5,
                                                       message: 'is not included in the list' }, on: :create
  validates :name, presence: true, uniqueness: true, on: :create
  validates :type, presence: true

  def self.total_capacity(type)
    where('type = ?', "#{type}").sum('capacity')
  end

  def self.available_responders(type)
    where('type = ? AND emergency_code IS NULL', "#{type}").sum('capacity')
  end

  def self.on_duty_responders(type)
    where('type = ? AND on_duty = ?', "#{type}", true).sum('capacity')
  end

  def self.ready_to_go_responders(type)
    where('type = ? AND on_duty = ? AND emergency_code IS NULL', "#{type}", true).sum('capacity')
  end
end
