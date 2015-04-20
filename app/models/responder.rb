class Responder < ActiveRecord::Base
  belongs_to :emergency, foreign_key: :emergency_code, primary_key: :code

  self.inheritance_column = :_type_disabled

  validates :capacity, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5,
                                                       message: 'is not included in the list' }, on: :create
  validates :name, presence: true, uniqueness: { message: 'has already been taken' }, on: :create
  validates :type, presence: true

  validates_absence_of :type, message: 'found unpermitted parameter: type', on: :update
  validates_absence_of :name, message: 'found unpermitted parameter: name', on: :update
  validates_absence_of :capacity, message: 'found unpermitted parameter: capacity', on: :update
  validates_absence_of :emergency_code, message: 'found unpermitted parameter: emergency_code'
  validates_absence_of :on_duty, message: 'found unpermitted parameter: on_duty'
  validates_absence_of :id, message: 'found unpermitted parameter: id'

  def self.total_capacity(type)
    where('type = ?', "#{type}").map(&:capacity).inject(0, :+)
  end

  def self.available_responders(type)
    where('type = ? AND emergency_code IS NULL', "#{type}").map(&:capacity).inject(0, :+)
  end

  def self.on_duty_responders(type)
    where('type = ? AND on_duty = ?', "#{type}", true).map(&:capacity).inject(0, :+)
  end

  def self.ready_to_go_responders(type)
    where('type = ? AND on_duty = ? AND emergency_code IS NULL', "#{type}", true).map(&:capacity).inject(0, :+)
  end
end
