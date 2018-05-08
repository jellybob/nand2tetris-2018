require "assembler/parser"

class Assembler
  attr_reader :source_file
  attr_reader :parser

  def initialize(filename, parser = Parser)
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
    output = parse.compact
    File.open(target_file, "w") do |f|
      f.print(output.join("\n"))
      f.print("\n")
    end
  end
end
