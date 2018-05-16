require "assembler/parser"
require "assembler/symboliser"

class Assembler
  attr_reader :source_file
  attr_reader :parser
  attr_reader :symboliser

  def initialize(filename, parser: Parser, symboliser: Symboliser)
    @source_file = filename
    @parser = parser
    @symboliser = symboliser
  end

  def target_file
    source_file.sub(/\.asm$/, ".hack")
  end

  def parser
    @parser
  end

  def load_source
    @source = File.read(source_file).lines.map do |l|
      l.sub(/\/\/.*$/, "").strip
    end.reject { |l| l.empty? }
  end

  def symbolise(source)
    symboliser.new.symbolise(source)
  end

  def parse(source)
    parser.new.parse(source)
  end

  def assemble
    output = parse(symbolise(load_source))
    File.open(target_file, "w") do |f|
      f.print(output.join("\n"))
      f.print("\n")
    end
  end
end
