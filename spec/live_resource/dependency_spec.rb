require "spec_helper"

describe LiveResource::Dependency do
  let(:dependency) { LiveResource::Dependency.new(resource, events, proc) }
  let(:resource) { double(LiveResource::Resource) }
  let(:events) { [:after_save, :after_destroy] }
  let(:proc) { double(Proc) }

  describe "watch" do

    subject { dependency.watch }

    it "should observe each event" do
      events.each { |event| dependency.should_receive(:observe).with(event).ordered }
      subject
    end

  end

  describe "invoke" do
    subject { dependency.invoke(event, *context) }

    let(:event) { :after_create }
    let(:context) { [ double(), double() ] }

    let(:proc) { double(Proc, arity: proc_arity) }
    let(:resource) { double(LiveResource::Resource, name: "blah") }
    let(:proc_arity) { }

    before do
      proc.stub_chain(:bind, :call)
    end

    it "should bind the proc to the resource" do
      proc.should_receive(:bind).with(resource)
      subject
    end

    context "when the proc accepts no arguments" do
      let(:proc_arity) { 0 }

      it "should invoke the proc with no arguments" do
        proc.bind.should_receive(:call).with()
        subject
      end
    end

    context "when the proc accepts the same number of arguments as the context array" do
      let(:proc_arity) { 2 }

      it "should invoke the proc" do
        proc.bind.should_receive(:call).with(*context)
        subject
      end
    end

    context "when the proc accepts more arguments than the context array" do
      let(:proc_arity) { 3 }

      it "should invoke the proc" do
        proc.bind.should_receive(:call).with(*context, event)
        subject
      end
    end
  end
end