class Assembler
  class Parser
    class AInstruction
      attr_reader :address

      def initialize(address)
        @address = address.to_i

        if self.address < 0
          raise Parser::InvalidAddressError, "Address #{address} provided, but addresses must not be negative"
        end
      end

      def to_s
        "0#{address.to_s(2).rjust(15, "0")}"
      end

      def inspect
        "#<Assembler::Parser::AInstruction address=#{address}>"
      end
    end
  end
end
