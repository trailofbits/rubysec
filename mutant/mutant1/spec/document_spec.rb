require 'spec_helper'

describe Document do
  let(:owner)      { User.new(name: 'Trent') }
  let(:authorizer) { User.new(name: 'Alice') }
  let(:authorized) { User.new(name: 'Bob')   }

  subject do
    described_class.new(
      title: 'World Domination',
      owner: owner
    )
  end

  describe "#authorized_users" do
    context "when #authorizations is empty" do
      it "should return []" do
        subject.authorized_users.should == []
      end
    end

    context "when #authorizations is not empty" do
      before do
        subject.authorizations << Authorization.new(
          authorizer: authorizer,
          authorized: authorized,
          document:   subject
        )
      end

      it "should return the authorized users from #authorizations" do
        subject.authorized_users.should == [authorized]
      end
    end
  end

  describe "#has_access?" do
    it "should determine when a user has access"
  end

  describe "#grant_access" do
    it "should grant access"
  end

  describe "#revoke_access" do
    it "should revoke access"
  end
end
