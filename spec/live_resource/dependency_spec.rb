require "spec_helper"

describe LiveResource::Dependency do
  let(:dependency) { LiveResource::Dependency.new(resource, target, proc) }

  let(:resource) { double(LiveResource::Resource) }
  let(:target) { :some_component }
  let(:proc) {}

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

    let(:proc_invocations) { [] }
    let(:proc_return_value) { { a: 'b' } }
    let(:proc) do
      # Preserve references to let'ed values inside Proc scope
      _proc_invocations  = proc_invocations
      _proc_return_value = proc_return_value

      Proc.new do |*args|
        _proc_invocations << { :self => self, :args => args }
        _proc_return_value
      end
    end

    it "should execute the proc in the context of the resource" do
      subject
      expect(proc_invocations.length).to be 1
      expect(proc_invocations.first[:self]).to be resource
    end

    it "should pass the context to the proc" do
      subject
      expect(proc_invocations.length).to be 1
      expect(proc_invocations.first[:args]).to eq context
    end
  end
end