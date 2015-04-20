if @emergency.errors.any?
  if [:id, :resolved_at].any? { |k| @emergency.errors.key?(k) }
    json.message @emergency.errors.first.last
  else
    json.message @emergency.errors
  end
else
  json.partial! 'emergencies/emergency', emergency: @emergency
  json.emergency do
    json.responders @emergency.responders.map(&:name)
    json.full_response @emergency.full_response
  end
end
