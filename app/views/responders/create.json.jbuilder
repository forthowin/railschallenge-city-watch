if @responder.errors.any?
  json.message @responder.errors
else
  json.partial! 'responders/responder', responder: @responder
end
