json.capacity do
  json.set! 'Fire' do
    json.array! [Responder.total_capacity('Fire'),
                 Responder.available_responders('Fire'),
                 Responder.on_duty_responders('Fire'),
                 Responder.ready_to_go_responders('Fire')]
  end
  json.set! 'Police' do
    json.array! [Responder.total_capacity('Police'),
                 Responder.available_responders('Police'),
                 Responder.on_duty_responders('Police'),
                 Responder.ready_to_go_responders('Police')]
  end
  json.set! 'Medical' do
    json.array! [Responder.total_capacity('Medical'),
                 Responder.available_responders('Medical'),
                 Responder.on_duty_responders('Medical'),
                 Responder.ready_to_go_responders('Medical')]
  end
end
