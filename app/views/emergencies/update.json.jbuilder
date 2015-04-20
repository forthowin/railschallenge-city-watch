json.partial! 'emergencies/emergency', emergency: @emergency

json.emergency do
  json.resolved_at @emergency.resolved_at
end
