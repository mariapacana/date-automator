require 'spec_helper'

describe User do

  let(:user) { User.create(first_name: "Maria",
                             last_name: "Pacana",
                             email: "maria@pacana.org",
                             phone_number: "+17776667777",
                             password: "bear") }
  let(:access_token) { "XXXXX"}

  before(:all) do
    user.authorizations.create(auth_type: "google",
                               access_token: access_token,
                               created_at: 2.hours.ago,
                               updated_at: 2.hours.ago)
  end

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
      end
    end

    context "with invalid phone number" do
      it "throws an argument error" do
        user.update_attributes(phone_number: "6asdf6")
        user.should_not be_valid
      end
    end

  end

  describe ".authenticate" do
    it "lets valid users log in" do
      logged_in_user = User.authenticate({email: "maria@pacana.org", password: "bear" })
      logged_in_user.should eq(user)
    end
  end

  describe "#opts_out_of_google_oauth?" do
    it "is set when a user opts out of google oauth" do
      user.disable_google
      expect(user.google_opt_out).to be_true
    end
  end

  describe "#enabled_google_oauth?" do
    it "tells you if a user has a google authorization" do
      expect(user.enabled_google_oauth?).to be_true
    end

    it "gives you back the access token" do
      expect(user.google_access_token).to eq(access_token)
    end
  end

  describe "#google_access_token_outdated?" do
    it "tells you when the access token is outdated" do
      expect(user.google_access_token_outdated?).to be_true
    end
  end

  describe "#update_google_access_token" do
    it "updates access tokens" do
      user.update_google_access_token("hey")
      expect(user.google_access_token).to eq("hey")
    end
  end

  after(:all) do
    User.destroy_all
  end
end