require "spec_helper"

describe "building a LiveResource" do

  let(:builder) do
    LiveResource::Builder.new(resource_name)
  end

  let(:resource_name) { :user }

  let(:resource) do
    builder.resource
  end

  let(:identifier_block_invocations) { [] }
  let(:identifier_block_return_value) { { a: 'b' } }
  let(:identifier_block) do
    # Preserve references to let'ed values inside Proc scope
    _identifier_block_invocations = identifier_block_invocations
    _identifier_block_return_value = identifier_block_return_value

    Proc.new { |*args| _identifier_block_invocations << args; _identifier_block_return_value }
  end

  # When a dependency fires, the block supplied to the builder should fire
  #                          the block should be able to publish protocol messages
  # Dependencies should be inspectable
  # Invoking the "identifier" method of the resource should invoke the supplied block
  #   - and return its value

  describe 'the created resource' do

    subject { resource }

    describe '#name' do
      subject { resource.name }

      expect_it { to eq(resource_name) }
    end

    context 'when an identifier block is given' do
      before do
        builder.identifier(&identifier_block)
      end

      describe '#identifier' do
        subject { resource.identifier *args }

        let(:args) { [:a, 1, true, {}] }

        it 'should invoke the supplied block' do
          subject
          expect(identifier_block_invocations.length).to be 1
          expect(identifier_block_invocations.first).to eq args
        end

        expect_it { to be identifier_block_return_value }
      end
    end

    context 'when a dependency is registered' do
      before do
        builder.depends_on(dependency_target, &dependency_block)
      end

      let(:dependency_target) { :some_component }

      let(:dependency_block_invocations) { [] }
      let(:dependency_block_return_value) { { a: 'b' } }
      let(:dependency_block) do
        # Preserve references to let'ed values inside Proc scope
        _dependency_block_invocations = dependency_block_invocations
        _dependency_block_return_value = dependency_block_return_value

        Proc.new { |*args| _dependency_block_invocations << args; _dependency_block_return_value }
      end

      expect_it { to depend_on(dependency_target) }

      context 'and the dependency is invoked' do
        subject { dependency.invoke event, *context }

        it 'should invoke the dependency block with the given context' do
          subject
          expect(dependency_block_invocations.length).to be 1
          expect(dependency_block_invocations.first).to eq args
        end
      end
    end
  end

end