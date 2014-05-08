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
end
