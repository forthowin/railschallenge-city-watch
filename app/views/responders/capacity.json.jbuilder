json.capacity do
  json.set! 'Fire' do
    json.array! capacity_of_fire_responders
  end
  json.set! 'Police' do
    json.array! capacity_of_police_responders
  end
  json.set! 'Medical' do
    json.array! capacity_of_medical_responders
  end
end
