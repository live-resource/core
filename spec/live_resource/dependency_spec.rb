require "spec_helper"

describe LiveResource::Dependency do
  let(:dependency) { LiveResource::Dependency.new(resource, proc) }

  let(:resource) { double(LiveResource::Resource) }
  let(:proc) { double(Proc) }

  describe "watch" do

    subject { dependency.watch }

    it "should raise an error" do
      expect(-> { subject }).to raise_error
    end

  end

  describe "invoke" do
    subject { dependency.invoke(*context) }

    let(:context) { [double(), double()] }
    let(:resource) { double(LiveResource::Resource, name: "blah") }

    before do
      proc.stub_chain(:bind, :call)
    end

    it "should bind the proc to the resource" do
      proc.should_receive(:bind).with(resource)
      subject
    end

    it "should invoke the proc with the context arguments" do
      proc.bind.should_receive(:call).with(*context)
      subject
    end
  end
end