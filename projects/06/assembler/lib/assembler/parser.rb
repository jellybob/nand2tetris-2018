require "assembler/parser/a_instruction"
require "assembler/parser/c_instruction"

class Assembler
  class Parser
    class ParseError < StandardError; end
    class InvalidAddressError < ParseError; end

    attr_reader :computations, :jumps
    attr_reader :lines

    def initialize(lines)
      @lines = lines
      @computations = operator_map(CInstruction::COMPUTATIONS)
      @jumps = operator_map(CInstruction::JUMPS)
    end

    def operator_map(m)
      m.keys.map { |k| Regexp.escape(k) }.join("|")
    end

    def parse
      @lines.map { |l| parse_line(l) }
    end

    def parse_line(line)
      case line
      when /^@(.*)/
        return AInstruction.new($1)
      when /^((A?M?D?)=)?(#{computations})(;(#{jumps}))?$/
        return CInstruction.new($2, $3, $5)
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
