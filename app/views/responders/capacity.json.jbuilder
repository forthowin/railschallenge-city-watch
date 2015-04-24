json.capacity do
  json.set! 'Fire' do
    json.array! [Responder.total_capacity('Fire').capacity,
                 Responder.available('Fire').capacity,
                 Responder.on_duty('Fire').capacity,
                 Responder.available_and_on_duty('Fire').capacity]
  end
  json.set! 'Police' do
    json.array! [Responder.total_capacity('Police').capacity,
                 Responder.available('Police').capacity,
                 Responder.on_duty('Police').capacity,
                 Responder.available_and_on_duty('Police').capacity]
  end
  json.set! 'Medical' do
    json.array! [Responder.total_capacity('Medical').capacity,
                 Responder.available('Medical').capacity,
                 Responder.on_duty('Medical').capacity,
                 Responder.available_and_on_duty('Medical').capacity]
  end
end
