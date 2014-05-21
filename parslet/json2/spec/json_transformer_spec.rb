require 'spec_helper'
require 'json_transformer'

describe JSONTransformer do
  describe "null" do
    let(:null) { {:null => Parslet::Slice.new("null", 0)} }

    it "should transform {:null=>\"null\"@0} into nil" do
      subject.apply(null).should == nil
    end
  end

  describe "boolean" do
    let(:boolean_true)  { {:boolean => Parslet::Slice.new("true", 0)}  }
    let(:boolean_false) { {:boolean => Parslet::Slice.new("false", 0)} }

    it "should transform {:boolean=>\"true\"@0} into true" do
      subject.apply(boolean_true).should == true
    end

    it "should transform {:boolean=>\"false\"@0} into false" do
      subject.apply(boolean_false).should == false
    end
  end

  describe "integer" do
    let(:integer) { {:integer => Parslet::Slice.new("100", 0)} }

    it "should transform {:integer=>\"100\"@0} into 100" do
      subject.apply(integer).should == 100
    end
  end

  describe "string" do
    let(:string)       { {:string => Parslet::Slice.new("foo", 0)} }
    let(:empty_string) { {:string => nil} }

    it "should transform {:string=>nil} into nil" do
      subject.apply(empty_string).should == nil
    end

    it "should transform {:string=>\"foo\"@0} into \"foo\"" do
      subject.apply(string).should == "foo"
    end
  end

  describe "array" do
    let(:empty_array)               { {:array => nil}                          }
    let(:nested_empty_array)        { {:array => {:array => nil}}              }
    let(:nested_empty_string_array) { {:array => {:array => {:string => nil}}} }

    let(:nested_empty_hash_array)   do
      {:array => {:array => {:hash_table => nil}}}
    end

    let(:singleton_array) do
      {:array => {:integer => Parslet::Slice.new("1", 0)} }
    end

    let(:array) do
      {
        :array => [
          {:null    => Parslet::Slice.new("null", 0)},
          {:boolean => Parslet::Slice.new("true", 1)},
          {:integer => Parslet::Slice.new("1", 2)},
          {:string  => Parslet::Slice.new("foo", 3)}
        ]
      }
    end

    let(:nested_array) do
      {
        :array => [
          {
            :array => [
              {:integer => Parslet::Slice.new("1",0)},
              {:integer => Parslet::Slice.new("2",1)}
            ]
          }
        ]
      }
    end

    it "should transform {:array=>nil} into nil" do
      subject.apply(empty_array).should == nil
    end

    it "should transform {:array=>{:array=>nil}} into nil" do
      subject.apply(nested_empty_array).should == nil
    end

    it "should transform {:array=>{:array=>{:string=>nil}}} into nil" do
      subject.apply(nested_empty_string_array).should == nil
    end

    it "should transform {:array=>{:array=>{:hash_table=>nil}}} into nil" do
      subject.apply(nested_empty_hash_array).should == nil
    end

    it "should transform {:array=>{:integer=>\"1\"@0}} into [1]" do
      subject.apply(singleton_array).should == [1]
    end

    it "should transform multi-element arrays" do
      subject.apply(array).should == [nil, true, 1, "foo"]
    end

    it "should preserve nested arrays" do
      subject.apply(nested_array).should == [[1,2]]
    end
  end

  describe "hash_table" do
    let(:empty_hash_table)     { {:hash_table => nil} }

    let(:singleton_hash_table) do
      {
        :hash_table => {
          :key   => {:string => Parslet::Slice.new("key",0)},
          :value => {:string => Parslet::Slice.new("value",1)}
        }
      }
    end

    let(:hash_table) do
      {
        :hash_table => [
          {
            :key   => {:string => Parslet::Slice.new("null",0)},
            :value => {:null   => Parslet::Slice.new("null",1)}
          },

          {
            :key   => {:string  => Parslet::Slice.new("boolean",2)},
            :value => {:boolean => Parslet::Slice.new("true",3)}
          },

          {
            :key   => {:string  => Parslet::Slice.new("integer",4)},
            :value => {:integer => Parslet::Slice.new("1",5)}
          },

          {
            :key   => {:string  => Parslet::Slice.new("string",6)},
            :value => {:string  => Parslet::Slice.new("foo",7)}
          }
        ]
      }
    end

    it "should transform {:hash_table=>nil} into nil" do
      subject.apply(empty_hash_table).should == nil
    end

    it "should transform {:hash_table=>{:key=>{:string=>\"key\"@0}, :value=>{:string=>\"value\"@1}}} into {\"key\"=>nil}" do
      subject.apply(singleton_hash_table).should == {"key" => "value"}
    end

    it "should transform multi-element hash tables" do
      subject.apply(hash_table).should == {
        "null"    => nil,
        "boolean" => true,
        "integer" => 1,
        "string"  => "foo"
      }
    end
  end
end
