if @responder.errors.any?
  if [:emergency_code, :id, :on_duty].any? { |k| @responder.errors.key?(k) }
    json.message @responder.errors.first.last
  else
    json.message @responder.errors
  end
else
  json.partial! 'responders/responder', responder: @responder
end
