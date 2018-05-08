class Assembler
  class Parser
    class CInstruction
      COMPUTATIONS = {
        "0" => 42,
        "1" => 63,
        "D" => 12,
      }.freeze

      attr_reader :dest, :comp, :jump

      def initialize(dest, comp, jump)
        @dest = dest || ""
        @comp = comp || ""
        @jump = jump || ""
      end

      def to_s
        "111#{a}#{comp_as_binary}#{dest_as_binary}#{jump_as_binary}"
      end

      def a
        "0"
      end

      def comp_as_binary
        COMPUTATIONS[comp].to_s(2).rjust(6, "0")
      end

      def dest_as_binary
        a = bit_include(dest, "A")
        m = bit_include(dest, "M")
        d = bit_include(dest, "D")

        [a,d,m].join("")
      end

      def jump_as_binary
        "000"
      end

      def bit_include(string, char)
        string.include?(char) ? "1" : "0"
      end
    end
  end
end
