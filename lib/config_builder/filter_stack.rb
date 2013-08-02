require 'config_builder/filter'

module ConfigBuilder
  class FilterStack

    def initialize
      @filter_stack = []
      @filter_stack << ConfigBuilder::Filter::Roles.new
    end

    # @param input [Hash]
    #
    # @return [Hash]
    def filter(input)
      @filter_stack.inject(input) do |current_input, filter|
        filter.run(current_input)
      end
    end
  end
end
