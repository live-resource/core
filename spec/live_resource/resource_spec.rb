require "spec_helper"
require "live_resource/resource"

describe LiveResource::Resource do

  let(:resource) { LiveResource::Resource.new(resource_name) }
  let(:resource_name) { "some_resource" }

  describe "#identifier" do
    subject { resource.identifier(:a, :b) }

    it "should raise an exception" do
      expect(lambda { subject }).to raise_exception
    end
  end

end