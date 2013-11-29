require 'spec_helper'

describe Phone do

  let(:phone) { Phone.new(phone_number: "+16668889999")}

  describe "#initialize" do  

    it { should have_many(:crushes) }
    it { should have_many(:exchanges) }

    context "with valid phone number" do
      it "is fine" do
        phone.should be_valid
      end
    end

    context "with invalid phone number" do
      it "throws an argument error" do
        phone.update_attributes(phone_number: "666-777-6666")
        phone.should_not be_valid
      end
    end

    it "sets the pin to 1" do
      expect(phone.next_pin).to eq(1)
    end
  end

  describe "#increment_pin" do
    it "increases the pin by 1" do
      expect{phone.increment_pin}.to change{phone.next_pin}.by(1)
    end
  end

  after(:all) do
    Phone.destroy_all
  end
end