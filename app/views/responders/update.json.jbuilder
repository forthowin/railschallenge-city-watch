if @responder.errors.any?
  json.message @responder.errors.messages.fetch(@key).first
else
  json.partial! 'responders/responder', responder: @responder
end
