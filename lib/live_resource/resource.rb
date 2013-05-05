module LiveResource
  class Resource

    attr_reader :name, :dependencies

    def initialize(name)
      @name = name
      @dependencies = Hash.new { |h,k| h[k] = [] }
    end

    def identifier(*context)
      raise "You must define an identifier method for the resource '#{@name}'"
    end

  end
end