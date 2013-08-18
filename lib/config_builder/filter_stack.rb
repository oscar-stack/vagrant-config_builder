require 'config_builder/filter'

module ConfigBuilder
  class FilterStack

    def initialize
      @filter_stack = []
    end

    # @param input [Hash]
    #
    # @return [Hash]
    def filter(input)
      set_filters(input.delete(:filters))

      @filter_stack.inject(input) do |current_input, filter|
        filter.set_config(current_input)
        filter.run
      end
    end

    private

    # @note The implementation of this method is not final, use at your own peril.
    # @api private
    def set_filters(list)
      if list.nil?
        @filter_stack << [
          ConfigBuilder::Filter::Roles.new,
          ConfigBuilder::Filter::Boxes.new,
        ]
      else
        @filter_stack = list
      end
    end
  end
end
