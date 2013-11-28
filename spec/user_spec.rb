require 'spec_helper'

describe User do

  let!(:user) { User.create(first_name: "Maria",
                         last_name: "Pacana",
                         email: "maria@pacana.org",
                         phone_number: "+17776667777",
                         password: "bear") }

  describe "#initialize" do  
    it { should have_many(:exchanges) }
    it { should have_many(:crushes) }
    it { should have_many(:free_times) }
    it { should have_many(:authorizations) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:password_hash) }

    context "with valid phone number" do
      it "is fine" do
        user.should be_valid
        puts user.errors
      end
    end

    context "with invalid phone number" do
      it "throws an argument error" do
        user.update_attributes(phone_number: "666-777-6666")
        user.should_not be_valid
      end
    end
  end

  describe ".authenticate" do
    it "lets valid users log in" do
      logged_in_user = User.authenticate({email: "maria@pacana.org",
                                          password: "bear" })
      puts logged_in_user
      logged_in_user.should eq(user)
    end
  end
end