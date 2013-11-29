require 'spec_helper'

describe Authorization do

  describe "#initialize" do  
    it { should belong_to(:user) }
    it { should validate_uniqueness_of(:auth_type).scoped_to(:user_id) }
  end

end