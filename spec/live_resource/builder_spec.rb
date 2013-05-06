require "spec_helper"

describe LiveResource::Builder do

  let(:builder) { LiveResource::Builder.new(resource_name, protocol, dependency_types) }
  let(:resource_name) { [:some, :thing] }
  let(:protocol) { double(LiveResource::Protocol) }
  let(:dependency_types) {}

  describe "#initialize" do
    subject { builder }

    let(:resource_class) { double(Class, :new => resource) }
    let(:resource) { double(LiveResource::Resource) }

    before do
      Class.stub(:new).and_return(resource_class)
      LiveResource::Resource.stub(:new).and_return(resource)
    end

    it "should create a new Resource class" do
      Class.should_receive(:new).with(LiveResource::Resource)
      subject
    end

    it "should intialize a new instance of the Resource subclass" do
      resource_class.should_receive(:new).with(resource_name, protocol)
      subject
    end
  end

  describe "#depends_on" do
    subject { builder.depends_on(target, &block) }

    let(:target) { :some_component }
    let(:block) { Proc.new {} }
    let(:dependency_types) { [dependency_type_1, dependency_type_2, dependency_type_3] }

    let(:dependency_type_1) { double('Dependency Type 1', accepts_target?: false) }
    let(:dependency_type_2) { double('Dependency Type 2', accepts_target?: true, new: nil) }
    let(:dependency_type_3) { double('Dependency Type 3', accepts_target?: false) }

    it 'should test each dependency type up to the first one which accepts the target' do
      dependency_type_1.should_receive(:accepts_target?).with(target)
      dependency_type_2.should_receive(:accepts_target?).with(target)
      dependency_type_3.should_not_receive(:accepts_target?)
      subject
    end

    context 'when one of the dependency types accepts the target' do
      let(:resource) { double(LiveResource::Resource, dependencies: []) }
      let(:dependency) { double(LiveResource::Dependency) }

      before do
        resource_subclass = double(Class, new: resource)
        Class.stub(new: resource_subclass)
        dependency_type_2.stub(new: dependency)
      end

      context 'and no extra arguments are given' do
        it 'should instantiate the dependency type that accepts the target' do
          dependency_type_2.should_receive(:new).with(resource, target, block)
          subject
        end
      end

      context 'and some extra arguments are given' do
        subject { builder.depends_on(target, *args, &block) }

        let(:args) { [:a, 2, true] }

        it 'should instantiate the dependency type that accepts the target with the extra arguments' do
          dependency_type_2.should_receive(:new).with(resource, target, block, *args)
          subject
        end
      end

      it "should add the result to the Resource's dependencies collection" do
        subject
        expect(resource.dependencies).to include(dependency)
      end
    end
  end

  describe "#identifier" do
    subject { builder.identifier(&block) }

    let(:block) { Proc.new { |a, b| [a, b] } }

    it "should define a new identifier method on the resource subclass" do
      subject
      expect(builder.resource.identifier(1, 2)).to eq([1, 2])
    end
  end

end