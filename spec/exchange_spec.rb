require 'spec_helper'

describe Exchange do

  let!(:user) { User.create(first_name: "Maria",
                            last_name: "Pacana",
                            email: "maria@pacana.org",
                            phone_number: "+17776667777",
                            password: "bear") }
  let!(:phone) { Phone.create(phone_number: "+16668889999") }
  let!(:crush) { Crush.create(first_name: "Egbert",
                              last_name: "Bert",
                              status: "not contacted",
                              user: user,
                              phone: phone) }
  let!(:exchange) {Exchange.create(user: user,
                                  phone: phone) }

  before(:all) do
    user
    phone
    crush
    exchange
  end

  describe "#initialize" do  

    it { should belong_to(:user) }
    it { should belong_to(:phone) }

    it "should be able to access the crush" do
      expect(exchange.crush).to eq(crush)
    end

    it "should set a valid PIN and text" do
      expect(exchange.pin).to eq(1)
      expect(exchange.request_text).to eq("Hello! Are you interested in Maria? Text Yes 1 or No 1 to respond.")
    end

  end

  after(:all) do
    Exchange.destroy_all
    Phone.destroy_all
    User.destroy_all
    Crush.destroy_all
  end
end