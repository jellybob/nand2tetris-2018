class Assembler
  class InstructionParser
    def initialize(content)
      @content = content
    end

    def parse
    end
  end

  attr_reader :source_file
  attr_reader :parser

  def initialize(filename, parser = InstructionParser)
    @source_file = filename
    @parser = parser
  end

  def target_file
    source_file.sub(/\.asm$/, ".hack")
  end

  def parser
    @parser
  end

  def parse
    content = File.read(source_file).lines.map(&:strip)
    parser.new(content).parse
  end

  def assemble
    output = parse
    File.open(target_file, "w") do |f|
      f.print(output.join("\n"))
      f.print("\n")
    end
  end
end
