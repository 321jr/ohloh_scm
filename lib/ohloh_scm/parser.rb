# :nocov:
# frozen_string_literal: true

require_relative 'parser/array_writer'

module OhlohScm
  class Parser
    class << self
      def parse(buffer = '', opts = {})
        buffer = StringIO.new(buffer) if buffer.is_a?(String)
        writer = (opts[:writer] || ArrayWriter.new) unless block_given?
        writer&.write_preamble(opts)

        internal_parse(buffer, opts) do |commit|
          if commit
            yield commit if block_given?
            writer&.write_commit(commit)
          end
        end

        if writer
          writer.write_postamble
          writer&.buffer
        end
      end

      def internal_parse; end
    end
  end
end
require_relative 'parser/svn_parser'
require_relative 'parser/xml_writer'
