require 'spec_helper'

describe User do

  before(:each) do
    let(:user) { User.new(first_name: "Maria",
                            last_name: "Pacana",
                            phone: "+16502008405")}
  end

  describe "#initialize" do  

    it { should have_many(:exchanges) }
    it { should have_many(:crushes) }
    it { should have_many(:free_times) }
    it { should have_many(:authorizations) }

    xit { should validate_presence_of(:first_name,
                                      :last_name,
                                      :email,
                                      :phone,
                                      :password_hash) }


    context "with invalid phone number" do
      xit "throws an argument error" do
        expect User.new(first_name: "Maria",
                         last_name: "Pacana",
                         phone: "650-200-9405").to raise_error(InvalidPhoneError)
      end
    end

    context "with valid phone number" do
      user.should be_valid
    end
  end
end