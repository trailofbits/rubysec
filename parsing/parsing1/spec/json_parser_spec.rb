require 'spec_helper'
require 'json_parser'

describe JSONParser do
  describe "null" do
    subject { super().null }

    it "should parse 'null'" do
      subject.parse('null').should have_key(:null)
    end
  end

  describe "boolean" do
    subject { super().boolean }

    it "should parse 'false'" do
      node = subject.parse('false')
      
      node[:boolean].should == 'false'
    end

    it "should parse 'true'" do
      node = subject.parse('true')
      
      node[:boolean].should == 'true'
    end
  end

  describe "integer" do
    subject { super().integer }

    it "should not parse ''" do
      lambda { subject.parse('') }.should raise_error(Parslet::ParseFailed)
    end

    it "should parse 0" do
      node = subject.parse('0')

      node[:integer].should == '0'
    end

    it "should parse -1" do
      node = subject.parse('-1')

      node[:integer].should == '-1'
    end

    it "should parse -100" do
      node = subject.parse('-100')

      node[:integer].should == '-100'
    end

    it "should parse 1" do
      node = subject.parse('1')

      node[:integer].should == '1'
    end

    it "should parse 100" do
      node = subject.parse('100')

      node[:integer].should == '100'
    end
  end

  describe "string" do
    subject { super().string }

    it "should parse \"\"" do
      node = subject.parse('""')

      node[:string].should == ""
    end

    it "should parse \"x\"" do
      node = subject.parse('"x"')

      node[:string].should == "x"
    end

    it "should parse \"xyz\"" do
      node = subject.parse('"xyz"')

      node[:string].should == "xyz"
    end

    it "should parse \"\\n\"" do
      node = subject.parse('"\n"')

      node[:string].should == "\\n"
    end
  end

  describe "array" do
    subject { super().array }

    it "should parse []" do
      node = subject.parse('[]')

      node.should have_key(:array)
    end

    it "should parse [1]" do
      node = subject.parse('[1]')

      node[:array][:integer].should == '1'
    end

    it "should parse [1,2]" do
      node = subject.parse('[1,2]')

      node[:array][0][:integer].should == '1'
      node[:array][1][:integer].should == '2'
    end

    it "should parse [1, 2]" do
      node = subject.parse('[1, 2]')

      node[:array][0][:integer].should == '1'
      node[:array][1][:integer].should == '2'
    end

    it "should parse [1, true, \"foo\"]" do
      node = subject.parse('[1, true, "foo"]')

      node[:array][0][:integer].should == '1'
      node[:array][1][:boolean].should == 'true'
      node[:array][2][:string].should  == 'foo'
    end
  end

  describe "hash_table" do
    subject { super().hash_table }

    it "should parse {}" do
      node = subject.parse('{}')

      node.should have_key(:hash_table)
    end

    it "should parse {\"x\":1}" do
      node = subject.parse('{"x":1}')

      node[:hash_table][:key][:string].should  == 'x'
      node[:hash_table][:value][:integer].should == '1'
    end

    it "should parse {\"x\": 1}" do
      node = subject.parse('{"x": 1}')

      node[:hash_table][:key][:string].should  == 'x'
      node[:hash_table][:value][:integer].should == '1'
    end

    it "should parse {\"x\": 1, \"y\": 2}" do
      node = subject.parse('{"x": 1, "y": 2}')

      node[:hash_table][0][:key][:string].should  == 'x'
      node[:hash_table][0][:value][:integer].should == '1'
      node[:hash_table][1][:key][:string].should  == 'y'
      node[:hash_table][1][:value][:integer].should == '2'
    end
  end
end
