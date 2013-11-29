require 'spec_helper'

describe Crush do

  let(:user) { User.create(first_name: "Maria",
                             last_name: "Pacana",
                             email: "maria@pacana.org",
                             phone_number: "+17776667777",
                             password: "bear") }

  let(:phone) { Phone.create(phone_number: "+16668889999")}

  let(:crush) { Crush.create(first_name: "Egbert",
                              last_name: "Bert",
                              status: "not contacted",
                              user: user,
                              phone: phone)}

  describe "#initialize" do  

    it { should belong_to(:user) }
    it { should belong_to(:phone) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:status) }

    context "with valid status" do
      it "is fine" do
        crush.should be_valid
      end
    end

    context "with invalid status" do
      it "throws an argument error" do
        crush.update_attributes(status: "alfkjalsdf")
        crush.should_not be_valid
      end
    end
  end

  after(:all) do
    User.destroy_all
    Crush.destroy_all
    Phone.destroy_all
  end
end