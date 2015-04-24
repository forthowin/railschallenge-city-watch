class Emergency < ActiveRecord::Base
  has_many :responders

  validates :code, presence: true, uniqueness: { message: 'has already been taken' }
  validates :fire_severity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :police_severity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :medical_severity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def dispatch
    total_dispatchers = []

    total_dispatchers << group_dispatch('Fire', fire_severity)
    total_dispatchers << group_dispatch('Police', police_severity)
    total_dispatchers << group_dispatch('Medical', medical_severity)

    update_full_response(total_dispatchers)
  end

  def clear_responders_emergency_code
    responders.each do |responder|
      responder.update_columns(emergency_code: nil, emergency_id: nil)
    end
  end

  private

  def group_dispatch(type, severity)
    return unless severity > 0
    on_duty_responders = Responder.where('type = ? AND on_duty = ?', "#{type}", true)
    return if on_duty_responders.empty?
    dispatcher_options = allocate_responders(on_duty_responders, severity)

    dispatcher_options.last.each do |dispatcher|
      dispatcher.update_columns(emergency_code: code, emergency_id: id)
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
