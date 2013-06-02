require "spec_helper"
require "live_resource/resource"

describe LiveResource::Resource do

  let(:resource_class) { Class.new(LiveResource::Resource) }
  let(:resource) { resource_class.new(resource_name, protocol) }
  let(:resource_name) { "some_resource" }
  let(:protocol) { double(LiveResource::Protocol) }

  describe "#intialize" do
    subject { resource }

    its(:name) { should be resource_name }

    it 'should retain its protocol' do
      expect(subject.instance_variable_get(:@protocol)).to be(protocol)
    end
  end

  describe "#identifier" do
    subject { resource.identifier(:a, :b) }

    context "when #_identifier is undefined" do
      it "should raise an exception" do
        expect(lambda { subject }).to raise_exception
      end
    end

    context "when #_identifier is defined" do
      let(:raw_identifier) { 'raw_identifier' }
      let(:encoded_identifier) { 'encoded_identifier' }

      before do
        _raw_identifier = raw_identifier
        resource_class.instance_eval do
          define_method(:_identifier) { |*args| _raw_identifier }
        end
        protocol.stub(encode_identifier: encoded_identifier)
      end

      it "should not raise an exception" do
        expect(lambda { subject }).to_not raise_exception
      end

      it "should encode the identifier" do
        protocol.should_receive(:encode_identifier).with(raw_identifier)
        subject
      end

      it "should return the encoded identifier" do
        expect(subject).to eq encoded_identifier
      end
    end

  end

  describe "#push" do
    subject { resource.push(*context) }

    let(:identifier) { 'a/b/c' }
    let(:context) { [:a, :b, :c] }

    before do
      resource.stub(identifier: identifier)
      protocol.stub(publish_resource_reset: nil)
    end

    it 'should generate the identifier' do
      resource.should_receive(:identifier).with(*context)
      subject
    end

    it 'should publish a resource reset' do
      protocol.should_receive(:publish_resource_reset).with(identifier)
      subject
    end
  end

end