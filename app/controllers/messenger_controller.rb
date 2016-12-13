class MessengerController < ApplicationController
	skip_before_filter  :verify_authenticity_token
  def validate
  	if params["hub.verify_token"] == "billion"
		@challenge = params["hub.challenge"]
		render :layout => false
	end
  end
  def first_entity_value(entities, entity)
	  return nil unless entities.has_key? entity
	  val = entities[entity][0]['value']
	  return nil if val.nil?
	  return val.is_a?(Hash) ? val['value'] : val
  end

  def conversation
  		messaging_events = params["entry"].first["messaging"]
	  	messaging_events.each_with_index do |event, key|
	  		if event["recipient"]["id"].to_s == "238255063235264"
					sender = event["sender"]["id"]
				      if event["optin"].present?
				      	text = event["optin"]["ref"]
				      	res = FacebookBot.new.send_text_message(sender, " how did you get here?  ")
				      elsif event["message"].present?
				      		msg_id = event["message"]["mid"]
				      		msg = event["message"]["text"]
				      		unless FbMessageRecord.where(:mid => msg_id.to_s).present?
				      			FbMessageRecord.create(:mid => msg_id.to_s, :sender => sender)
	  							unless Facebook.where(:code => sender).present?
									Facebook.create(:code => sender, :notify => true)
								end
								@requester = Facebook.where(:code => sender).first
								session_id = "#{sender.to_i + 11}"
						      	access_token = 'S25R4EILYAKLQKT2C5IOBFSDNKVYII3D' #recycle-en
							    actions = {
							      :say => -> (session_id, context, msg) {
							        res = FacebookBot.new.send_text_message(sender, msg)
							      },
							      :merge => -> (session_id, context, entities, msg) {
							      	byebug
							        intent = first_entity_value entities, 'intent'
							        @order =  Order.where(:facebook_id => @requester.id, :status => "pre").first_or_create
							        vidrio = first_entity_value entities, 'vidrio'
							        @order.update(:vidrio => vidrio) if vidrio.to_i > 0
							        carton = first_entity_value entities, 'carton'
							        @order.update(:carton => carton) if carton.to_i > 0
							        lata = first_entity_value entities, 'lata'
							        @order.update(:lata => lata) if lata.to_i > 0
							        plastico = first_entity_value entities, 'plastico'
							        @order.update(:plastico => plastico) if plastico.to_i > 0
							        address = first_entity_value entities, 'location'
							        @order.update(:address => address) unless address.nil?
							        description = first_entity_value entities, 'message_body'
							        @order.update(:description => description) unless description.nil?
							        context['intent'] = intent
								    context['vidrio'] = vidrio unless vidrio.nil? 	
								    context['carton'] = carton unless carton.nil?
								    context['lata'] = lata unless lata.nil?
								    context['plastico'] = plastico unless plastico.nil?
								    context['location'] = address unless address.nil?
								    context['message_body'] = description unless description.nil?
							        return context
							      },
							      :error => -> (session_id, context, error) {
							        p error.message
							      },
								  :'requestPickup' => -> (session_id, context) {
								  	@order =  Order.where(:facebook_id => @requester.id, :status => "pre").first
								  	@order.update(:status => "Ordered")
								  	res = FacebookBot.new.send_text_message(sender, "Sir, The job is completed")
								    # context['joke'] = all_jokes[context['cat'] || 'default'].sample
								    # return context
								  },
							    }
							    client = Wit.new access_token, actions
							    resp = client.run_actions session_id, msg, {}
				      		end
				      elsif event["postback"].present?
				      	
				      end
			end
	 	end
  end

  def allocator
  end
end
