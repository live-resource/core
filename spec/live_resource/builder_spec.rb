require "spec_helper"

describe LiveResource::Builder do

  let(:builder) { LiveResource::Builder.new(resource_name) }
  let(:resource_name) { [:some, :thing] }

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
      resource_class.should_receive(:new).with(resource_name)
      subject
    end
  end

  #describe "#depends_on" do
  #  subject { builder.depends_on(target, *events, &block) }
  #
  #  let(:target) { class1 }
  #  let(:events) { [:after_create, :after_save] }
  #  let(:block) { Proc.new {} }
  #
  #  let(:class1) { Class.new(ActiveRecord::Base) }
  #
  #  it "should set up the dependency on the given model classes" do
  #    builder.resource.should_receive(:depends_on).with(target, events, block)
  #    subject
  #  end
  #end

  describe "#identifier" do
    subject { builder.identifier(&block) }

    let(:block) { Proc.new { |a, b| [a, b] } }

    it "should define a new identifier method on the resource subclass" do
      subject
      expect(builder.resource.identifier(1,2)).to eq([1, 2])
    end
  end

  describe "#resource_method" do
    subject { builder.resource_method }

    it "should return a Proc" do
      expect(subject).to be_a(Proc)
    end

    describe "the Proc" do
      subject { builder.resource_method.call }

      it "should return the resource" do
        expect(subject).to be(builder.resource)
      end
    end
  end

end