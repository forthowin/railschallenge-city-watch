if @emergency.errors.any?
  if [:id, :resolved_at].any? { |k| @emergency.errors.key?(k) }
    json.message @emergency.errors.first.last
  else
    json.message @emergency.errors
  end
else
  json.emergency do
    json.code @emergency.code
    json.fire_severity @emergency.fire_severity
    json.police_severity @emergency.police_severity
    json.medical_severity @emergency.medical_severity
  end
end