json.emergencies @emergencies do |emergency|
  json.code emergency.code
  json.fire_severity emergency.fire_severity
  json.police_severity emergency.police_severity
  json.medical_severity emergency.medical_severity
end

json.full_responses [Emergency.where('full_response = ?', true).count, Emergency.where('resolved_at IS NOT NULL').count]
