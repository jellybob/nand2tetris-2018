require "assembler/parser/a_instruction"

class Assembler
  class Parser
    class ParseError < StandardError; end
    class InvalidAddressError < ParseError; end

    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def parse
      @lines.map { |l| parse_line(l) }
    end

    def parse_line(line)
      case line
      when /^@(.*)/
        return AInstruction.new($1)
      end
    end
  end
end
