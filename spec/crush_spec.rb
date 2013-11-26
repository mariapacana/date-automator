require 'spec_helper'

describe Crush do

  let(:crush) { Crush.new(first_name: "Maria",
                          last_name: "Pacana",
                          phone: "+16502008405")}

  describe "#initialize" do  
    it { should have_many(:exchanges) }
    it { should belong_to(:user) }
    xit { should have_many(:pins) }

    context "with invalid phone number" do
      xit "throws an argument error" do
        expect Crush.new(first_name: "Maria",
                         last_name: "Pacana",
                         phone: "650-200-9405").to raise_error(InvalidPhoneError)
      end
    end

    context "with valid phone number" do

    end
  end
  #valid and invalid phone numbers?
end