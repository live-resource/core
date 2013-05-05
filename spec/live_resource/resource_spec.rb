require "spec_helper"
require "live_resource/resource"

describe LiveResource::Resource do

  let(:resource) { LiveResource::Resource.new(resource_name) }
  let(:resource_name) { "some_resource" }

  it "should include the sync protocol" do
    expect(LiveResource::Resource.include?(LiveResource::Protocol))
  end

  describe "#identifier" do
    subject { resource.identifier(:a, :b) }

    it "should raise an exception" do
      expect(lambda { subject }).to raise_exception
    end
  end

  #describe "#depends_on" do
  #  subject { resource.depends_on(target, events, block) }
  #
  #  let(:target) { Class.new() {} }
  #  let(:events) { [:after_create] }
  #  let(:block) { Proc.new() {} }
  #  let(:dependency) { double(LiveResource::Dependency, watch: nil) }
  #
  #  before do
  #    resource.stub(:new_dependency).and_return(dependency)
  #  end
  #
  #  it "should create a new dependency on the target for the events" do
  #    resource.should_receive(:new_dependency).with(target, events, block).and_return(dependency)
  #    subject
  #  end
  #
  #  it "should watch the dependency" do
  #    dependency.should_receive(:watch)
  #    subject
  #  end
  #
  #  context "if no proc block is given" do
  #    let(:block) { nil }
  #
  #    it "should raise an error" do
  #      expect(-> { subject }).to raise_exception
  #    end
  #  end
  #end

  #describe "#dependencies_on" do
  #  subject { resource.dependencies_on(target, events) }
  #
  #  let(:proc) { Proc.new {} }
  #  let(:model1) { Class.new(ActiveRecord::Base) }
  #  let(:model2) { Class.new(ActiveRecord::Base) }
  #
  #  before do
  #    resource.depends_on(model1, [:after_create, :after_destroy], proc)
  #    resource.depends_on(model1, [:after_save], proc)
  #    resource.depends_on(model2, [:after_save], proc)
  #  end
  #
  #  context "when no events are given" do
  #    let(:target) { model1 }
  #    let(:events) { nil }
  #
  #    it "should return all dependencies on the given target" do
  #      expect(subject.length).to be(2)
  #      expect(subject[0].model_class).to eq(model1)
  #      expect(subject[1].model_class).to eq(model1)
  #    end
  #  end
  #
  #  context "when some events are given" do
  #    let(:target) { model1 }
  #    let(:events) { [:after_create, :after_destroy] }
  #
  #    it "should return dependencies on the given target with a matching events array" do
  #      expect(subject.length).to be(1)
  #      expect(subject[0].model_class).to eq(model1)
  #      expect(subject[0].events).to eq(events)
  #    end
  #  end
  #end

  #describe "#dependent_on?" do
  #  subject { resource.dependent_on?(target, events) }
  #
  #  let(:target) { double(Group) }
  #  let(:events) { [:after_create, :after_destroy] }
  #  let(:dependencies) { [] }
  #
  #  before do
  #    resource.stub(:dependencies_on).and_return(dependencies)
  #  end
  #
  #  it "should get the dependencies on the target" do
  #    resource.should_receive(:dependencies_on).with(target, events).and_return(dependencies)
  #    subject
  #  end
  #
  #  context "when there are some matching dependencies" do
  #    let(:dependencies) { [ double(LiveResource::Dependency) ] }
  #    it { should be_true }
  #  end
  #
  #  context "when there are no matching dependencies" do
  #    let(:dependencies) { [] }
  #    it { should be_false }
  #  end
  #end

  #describe "#new_dependency" do
  #  subject { resource.new_dependency(target, events, proc) }
  #
  #  let(:target) { double(Group) }
  #  let(:events) { [:after_create, :after_destroy] }
  #  let(:proc) { Proc.new {} }
  #
  #  it "should initialize an ActiveRecordDependency" do
  #    LiveResource::Dependencies::ActiveRecordDependency.should_receive(:new)
  #      .with( resource, target, events, proc )
  #    subject
  #  end
  #
  #end

end