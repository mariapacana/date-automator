require 'spec_helper'

describe Exchange do

  let(:user) { User.new(first_name: "Maria",
                             last_name: "Pacana",
                             email: "maria@pacana.org",
                             phone_number: "+17776667777",
                             password: "bear") }
  let(:phone) { Phone.new(phone_number: "+16668889999") }
  let(:exchange) {Exchange.new(user: user,
                               phone: phone,
                               request_text: "Hey") }

  describe "#initialize" do  

    it { should belong_to(:user) }
    it { should belong_to(:phone) }

    it "should set a valid PIN" do
      exchange.save!
      expect(exchange.pin).to eq(1)
    end

  end

  after(:all) do
    Exchange.destroy_all
    Phone.destroy_all
    User.destroy_all
  end
end