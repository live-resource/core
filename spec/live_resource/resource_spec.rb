require "spec_helper"
require "live_resource/resource"

describe LiveResource::Resource do

  let(:resource) { LiveResource::Resource.new(resource_name, protocol) }
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

    it "should raise an exception" do
      expect(lambda { subject }).to raise_exception
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