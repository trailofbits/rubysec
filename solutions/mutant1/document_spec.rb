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

  describe "#has_access" do
    context "when the user is the owner" do
      it "should return true" do
        subject.has_access?(owner).should be_truthy
      end
    end

    context "when the user is authorized" do
      before do
        subject.authorizations << Authorization.new(
          authorizer: authorizer,
          authorized: authorized,
          document:   subject
        )
      end

      it "should return true" do
        subject.has_access?(authorized).should be_truthy
      end
    end

    context "when the user is the owner and has been authorized access" do
      before do
        subject.authorizations << Authorization.new(
          authorizer: owner,
          authorized: owner,
          document:   subject
        )
      end

      it "should return false" do
        subject.has_access?(owner).should be_falsey
      end
    end
  end

  describe "#grant_access" do
    context "when the authorizer has access" do
      before do
        subject.authorizations << Authorization.new(
          authorizer: owner,
          authorized: authorizer,
          document:   subject
        )
      end

      context "when the authorized already has access" do
        before do
          subject.authorizations << Authorization.new(
            authorizer: authorizer,
            authorized: authorized,
            document:   subject
          )
        end

        it "should raise an exception" do
          lambda {
            subject.grant_access(authorizer,authorized)
          }.should raise_error("User '#{authorized}' already has access to the document")
        end
      end

      context "when the authorized clearance is equal to the documents" do
        let(:authorized) do
          User.new(name: 'Bob', clearance: subject.clearance)
        end

        before { subject.grant_access(authorizer,authorized) }

        let(:authorization) { subject.authorizations.last }

        it "should add the authorization" do
          authorization.document.should   == subject
          authorization.authorizer.should == authorizer
          authorization.authorized.should == authorized
        end
      end

      context "when the authorized clearance is greater to the documents" do
        let(:authorized) do
          User.new(name: 'Bob', clearance: subject.clearance + 1)
        end

        before { subject.grant_access(authorizer,authorized) }

        let(:authorization) { subject.authorizations.last }

        it "should add the authorization" do
          authorization.document.should   == subject
          authorization.authorizer.should == authorizer
          authorization.authorized.should == authorized
        end
      end

      context "when the authorized clearance is less than the documents" do
        let(:authorized) do
          User.new(name: 'Bob', clearance: subject.clearance - 1)
        end

        it "should raise an UnauthorizedUser exception" do
          lambda {
            subject.grant_access(authorizer,authorized)
          }.should raise_error(UnauthorizedUser,"User '#{authorized}' does not have appropriate clearance")
        end
      end
    end

    context "when the authorizer does not have access" do
      it "should raise an UnauthorizedUser exception" do
        lambda {
          subject.grant_access(authorizer,authorized)
        }.should raise_error(UnauthorizedUser,"User '#{authorizer}' does not have appropriate clearance")
      end
    end
  end

  describe "#revoke_access" do
    context "when the authorizer has access" do
      before do
        subject.authorizations << Authorization.new(
          authorizer: owner,
          authorized: authorizer,
          document:   subject
        )
      end

      context "when the authorized is the owner" do
        it "should raise an exception" do
          lambda {
            subject.revoke_access(authorizer,owner)
          }.should raise_error("User '#{owner}' is the owner of this document!")
        end
      end

      context "when the authorized was never granted access" do
        it "should raise an exception" do
          lambda {
            subject.revoke_access(authorizer,authorized)
          }.should raise_error("User '#{authorized}' does not have access to the document")
        end
      end

      context "when the authorizer does not match that in the authorization" do
        before do
          subject.authorizations << Authorization.new(
            authorizer: owner,
            authorized: authorized,
            document:   subject
          )
        end

        it "should raise an exception" do
          lambda {
            subject.revoke_access(authorizer,authorized)
          }.should raise_error("User '#{authorizer}' is not allowed to revoke access for User '#{authorized}'")
        end
      end

      context "when the authorized was granted access by the authorizer" do
        let(:authorization) do
          Authorization.new(
            authorizer: authorizer,
            authorized: authorized,
            document:   subject
          )
        end

        before { subject.authorizations << authorization      }
        before { subject.revoke_access(authorizer,authorized) }

        it "should remove the authorization" do
          subject.authorizations.should_not include(authorization)
        end
      end
    end

    context "when the authorizer does not have access" do
      it "should raise an UnauthorizedUser exception" do
        lambda {
          subject.revoke_access(authorizer,authorized)
        }.should raise_error(UnauthorizedUser,"User '#{authorizer}' does not have appropriate clearance")
      end
    end
  end
end
