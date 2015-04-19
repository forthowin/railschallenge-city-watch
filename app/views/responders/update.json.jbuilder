if @responder.errors.any?
  json.message @responder.errors.messages.fetch(@key).first
else
  json.partial! 'responders/success', responder: @responder
end