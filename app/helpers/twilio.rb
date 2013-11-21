helpers do

  def new_client
    Twilio::REST::Client.new('ACf158366c6279b976ccaa2f0c03a957f7',  
                             'e85498b435f882d4cb4f7d63170d1321')
  end

  def send_sms(sender_phone, recipient_phone, body)
    puts "SMSed #{recipient_phone}"
    client = new_client
    client.account.sms.messages.create(
      from: sender_phone,
      to: recipient_phone,
      body: body)
  end

  def respond_sms(friend)
    twiml = Twilio::TwiML::Response.new do |r|
      r.Sms "Hey #{friend.name}. Thanks for the message!"
    end
    twiml.text
  end

  def standardize_phone(phone)
    phone.gsub!(/(\D)/,"")
    if phone.length == 11
      phone.insert(0, '+')
    elsif phone.length == 10
      phone.insert(0, '+1') 
    end
    phone
  end

end