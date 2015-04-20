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

  def group_dispatch(type, severity)
    on_duty_responders = Responder.where('type = ? AND on_duty = ?', "#{type}", true)

    dispatcher_options = dispatch_subset(on_duty_responders, severity)

    dispatcher_options.last.each do |dispatcher|
      dispatcher.update_column(:emergency_code, code)
    end

    dispatcher_options.last
  end

  def dispatch
    total_dispatchers = []
    if fire_severity > 0
      total_dispatchers << group_dispatch('Fire', fire_severity)
    end

    if police_severity > 0
      total_dispatchers << group_dispatch('Police', police_severity)
    end

    if medical_severity > 0
      total_dispatchers << group_dispatch('Medical', medical_severity)
    end

    if total_dispatchers.flatten.map(&:capacity).inject(:+) == fire_severity + police_severity + medical_severity or total_dispatchers.empty?
      update_column(:full_response, true)
    end
  end

  def dispatch_subset(objs, reference_value)
    previous_objs = []
    objs.each do |obj|
      new_objs = []
      new_objs << [obj] if obj.capacity <= reference_value
      previous_objs.each do |previous_obj|
        current_obj = previous_obj + [ obj ]
        new_objs << current_obj if current_obj.map(&:capacity).inject(0){|accumulator,value|accumulator+value} <= reference_value
      end
      previous_objs = previous_objs + new_objs
    end
    previous_objs
  end
end
