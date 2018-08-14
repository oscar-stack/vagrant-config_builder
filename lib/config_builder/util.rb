module ConfigBuilder
  # Utility functions.
  module Util
    # Recursively cast hash keys to symbols
    #
    # @param hash [Hash] A hash of keys and values.
    #
    # @return [Hash] The same hash, but with all keys transformed to symbols.
    def self.symbolize(hash)
      transformed_data = hash.map do |k, v|
                           v = symbolize(v) if v.is_a?(Hash)
                           [k.to_sym, v]
                         end

      Hash[transformed_data]
    end
  end
end
