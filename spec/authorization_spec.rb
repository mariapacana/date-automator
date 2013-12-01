require 'spec_helper'

describe Authorization do

  let(:user) { User.create(first_name: "Maria",
                             last_name: "Pacana",
                             email: "maria@pacana.org",
                             phone_number: "+17776667777",
                             password: "bear") }

  describe "#initialize" do  
    it { should belong_to(:user) }
    it { should validate_uniqueness_of(:auth_type).scoped_to(:user_id) }
  end

  after(:all) do
    User.destroy_all
    Authorization.destroy_all
  end
end