json.capacity do
  json.set! 'Fire' do
    json.array! [@total_fire_capacity, @available_fire_responder, @on_duty_fire_responder, @fire_responder]
  end
  json.set! 'Police' do
    json.array! [@total_police_capacity, @available_police_responder, @on_duty_police_responder, @police_responder]
  end
  json.set! 'Medical' do
    json.array! [@total_medical_capacity, @available_medical_responder, @on_duty_medical_responder, @medical_responder]
  end
end