require "assembler/parser/a_instruction"
require "assembler/parser/c_instruction"

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
      when /^((A|M|D|AD|AM|MD|AMD)=)?(0|1|D)$/
        return CInstruction.new($2, $3, nil)
      when /^\/\//
        return nil
      when /^$/
        return nil
      else
        return line
      end
    end
  end
end
