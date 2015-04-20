class Emergency < ActiveRecord::Base
  has_many :responders, primary_key: :code, foreign_key: :emergency_code

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

  def dispatch
    total_dispatchers = []

    total_dispatchers << group_dispatch('Fire', fire_severity)
    total_dispatchers << group_dispatch('Police', police_severity)
    total_dispatchers << group_dispatch('Medical', medical_severity)

    update_full_response(total_dispatchers)
  end

  private

  def group_dispatch(type, severity)
    return unless severity > 0
    on_duty_responders = Responder.where('type = ? AND on_duty = ?', "#{type}", true)
    return if on_duty_responders.empty?
    dispatcher_options = allocate_responders(on_duty_responders, severity)

    dispatcher_options.last.each do |dispatcher|
      dispatcher.update_column(:emergency_code, code)
    end

    dispatcher_options.last
  end

  def update_full_response(total_dispatchers)
    total_capacity = total_dispatchers.flatten.compact.map(&:capacity).inject(:+)
    total_severity = fire_severity + police_severity + medical_severity

    update_column(:full_response, true) if total_capacity == total_severity || total_dispatchers.compact.empty?
  end

  def allocate_responders(objs, target)
    previous_objs = []

    objs.each do |obj|
      new_objs = []
      new_objs << [obj] if obj.capacity <= target

      previous_objs.each do |previous_obj|
        current_obj = previous_obj + [obj]
        new_objs << current_obj if current_obj.map(&:capacity).inject(0, :+) <= target
      end

      previous_objs += new_objs
    end

    previous_objs << objs if previous_objs.empty?
    previous_objs
  end
end
