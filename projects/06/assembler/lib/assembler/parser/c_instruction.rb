class Assembler
  class Parser
    class CInstruction
      COMPUTATIONS = {
        "0"   => 0b0101010,
        "1"   => 0b0111111,
        "-1"  => 0b0111010,
        "D"   => 0b0001100,
        "A"   => 0b0110000,
        "!D"  => 0b0001101,
        "!A"  => 0b0110001,
        "-D"  => 0b0001111,
        "-A"  => 0b0110011,
        "D+1" => 0b0011111,
        "A+1" => 0b0110111,
        "D-1" => 0b0001110,
        "A-1" => 0b0110010,
        "D+A" => 0b0000010,
        "D-A" => 0b0010011,
        "A-D" => 0b0000111,
        "D&A" => 0b0000000,
        "D|A" => 0b0010101,
        "M"   => 0b1110000,
        "!M"  => 0b1110001,
        "M+1" => 0b1110111,
        "M-1" => 0b1110010,
        "D+M" => 0b1000010,
        "D-M" => 0b1010011,
        "M-D" => 0b1000111,
        "D&M" => 0b1000000,
        "D|M" => 0b1010101,
      }.freeze

      JUMPS = {
        "JGT" => 0b001,
        "JEQ" => 0b010,
        "JGE" => 0b011,
        "JLT" => 0b100,
        "JNE" => 0b101,
        "JLE" => 0b110,
        "JMP" => 0b111,
      }.freeze

      attr_reader :dest, :comp, :jump

      def initialize(dest, comp, jump)
        @dest = dest || ""
        @comp = comp || ""
        @jump = jump || ""
      end

      def to_s
        "111#{comp_as_binary}#{dest_as_binary}#{jump_as_binary}"
      end

      def comp_as_binary
        COMPUTATIONS[comp].to_s(2).rjust(7, "0")
      end

      def dest_as_binary
        a = bit_include(dest, "A")
        m = bit_include(dest, "M")
        d = bit_include(dest, "D")

        [a,d,m].join("")
      end

      def jump_as_binary
        JUMPS.fetch(jump, 0).to_s(2).rjust(3, "0")
      end

      def bit_include(string, char)
        string.include?(char) ? "1" : "0"
      end
    end
  end
end
