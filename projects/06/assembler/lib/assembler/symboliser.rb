class Assembler
  class Symboliser
    DEFAULT_SYMBOLS = {
      "SP" => 0x000,
      "LCL" => 0x001,
      "ARG" => 0x002,
      "THIS" => 0x003,
      "THAT" => 0x004,
      "R0" => 0x000,
      "R1" => 0x001,
      "R2" => 0x002,
      "R3" => 0x003,
      "R4" => 0x004,
      "R5" => 0x005,
      "R6" => 0x006,
      "R7" => 0x007,
      "R8" => 0x008,
      "R9" => 0x009,
      "R10" => 0x00a,
      "R11" => 0x00b,
      "R12" => 0x00c,
      "R13" => 0x00d,
      "R14" => 0x00e,
      "R15" => 0x00f,
      "SCREEN" => 0x4000,
      "KBD" => 0x6000,
    }.freeze

    NODE_TYPES = {
      label: /^\((.*)\)$/,
      comment: /^\/\//,
      address: /^@(.*)/,
      instruction: /.*/,
    }.freeze

    attr_reader :symbols
    attr_accessor :next_free
    attr_accessor :next_instruction

    def initialize
      @symbols = DEFAULT_SYMBOLS.dup
      @next_free = 0x010
      @next_instruction = 0
    end

    def symbolise(source)
      nodes = source.map { |l| parse_node(l) }

      nodes.each do |node|
        case node[:type]
        when :label
          symbols[node[:symbol]] ||= self.next_instruction
        when :address
          symbol = node[:symbol]
          unless symbols.key?(symbol)
            symbols[symbol] = self.next_free
            self.next_free += 1
          end
        end

        self.next_instruction += 1 if node[:increment]
      end

      nodes.map do |node|
        next if node[:skip]

        if node[:type] == :address
          symbol = node[:symbol]
          node[:line].sub(symbol, symbols[symbol].to_s)
        else
          node[:line]
        end
      end.compact
    end

    def parse_node(line)
      node_type = NODE_TYPES.find do |key, regex|
        regex.match?(line)
      end

      {
        type: node_type[0],
        symbol: node_type[1].match(line)[1],
        increment: node_type[0] == :address || node_type[0] == :instruction,
        line: line,
        skip: node_type[0] == :label || node_type[0] == :comment
      }
    end
  end
end
