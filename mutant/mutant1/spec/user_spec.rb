require 'spec_helper'

describe User do
  describe "#documents" do
    let(:authorizer) { described_class.new(name: 'Alice')      }
    let(:document)   { Document.new(title: 'Too Many Secrets') }

    subject { described_class.new(name: 'Bob') }

    context "when #authorizations is empty" do
      it "should return []" do
        subject.documents.should == []
      end
    end

    context "when #authorizations is not empty" do
      before do
        subject.authorizations << Authorization.new(
          authorizer: authorizer,
          authorized: subject,
          document:   document
        )
      end

      it "should return the documents" do
        subject.documents.should == [document]
      end
    end
  end

  describe "#to_s" do
    let(:name) { 'Bob' }

    subject { described_class.new(name: name) }

    it "should return the name" do
      subject.to_s.should == name
    end
  end

  describe '#eql?' do
    let(:user1) { User.new(name: name1, clearance: clearance1, authorizations: authorizations1) }
    let(:user2) { User.new(name: name2, clearance: clearance2, authorizations: authorizations2) }
    let(:name1) { 'Bob' }
    let(:clearance1) { 5 }
    let(:authorizations1) { [1, 2, 3] }

    context 'same name' do
      let(:name2) { 'Bob' }
      
      context 'same clearance' do
        let(:clearance2) { 5 }
        
        context 'same authorizations' do
          let(:authorizations2) { [1, 2, 3] }

          it('should be true') { expect(user1).to eql user2 }
        end

        context 'different authorizations' do
          let(:authorizations2) { [] }

          it('should be false') { expect(user1).to_not eql user2 }
        end
      end

      context 'different clearence' do
        let(:clearance2) { 10 }

        context 'same authorizations' do
          let(:authorizations2) { authorizations1 }

          it('should be false') { expect(user1).to_not eql user2 }
        end

        context 'different authorizations' do
          let(:authorizations2) { [] }

          it('should be false') { expect(user1).to_not eql user2 }
        end
      end
    end

    context 'different name' do
      let(:name2) { 'Kris' }
      
      context 'same clearance' do
        let(:clearance2) { 5 }
        
        context 'same authorizations' do
          let(:authorizations2) { [1, 2, 3] }

          it('should be false') { expect(user1).to_not eql user2 }
        end

        context 'different authorizations' do
          let(:authorizations2) { [] }

          it('should be false') { expect(user1).to_not eql user2 }
        end
      end

      context 'different clearence' do
        let(:clearance2) { 10 }

        context 'same authorizations' do
          let(:authorizations2) { [1, 2, 3] }

          it('should be false') { expect(user1).to_not eql user2 }
        end

        context 'different authorizations' do
          let(:authorizations2) { [] }

          it('should be false') { expect(user1).to_not eql user2 }
        end
      end
    end
  end
end
