require "live_resource/protocol"
#require "live_resource/dependencies/active_record_dependency"

module LiveResource
  class Resource
    include Protocol

    attr_reader :name, :dependencies

    def initialize(name)
      @name = name
      @dependencies = Hash.new { |h,k| h[k] = [] }
    end

    def identifier(*context)
      raise "You must define an identifier method for the resource '#{@name}'"
    end



    #def depends_on(target, events, proc)
    #  raise "You must supply a proc for the dependency" if proc.nil?
    #  @dependencies[target] << dependency = new_dependency(target, events, proc)
    #  dependency.watch
    #end
    #
    #def dependencies_on(target, events = nil)
    #  if events
    #    @dependencies[target].select { |d| d.events == events }
    #  else
    #    @dependencies[target]
    #  end
    #end
    #
    #def dependent_on?(target, events = nil)
    #  not dependencies_on(target, events).empty?
    #end
    #
    ## Initialize a new dependency on the target object.
    ## The only supported targets are ActiveRecord model classes.
    #def new_dependency(target, events, proc)
    #  LiveResource::Dependencies::ActiveRecordDependency.new(self, target, events, proc)
    #end
  end
end