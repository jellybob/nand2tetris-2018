require "assembler"

describe Assembler do
  class TestParser
    def parse(source)
      source
    end
  end

  class TestSymboliser
    def symbolise(source)
      source.map { |l| "-- #{l}" }
    end
  end

  before do
    @filename = "spec/fixtures/comment_only.asm"
    @asm = Assembler.new(@filename)
  end

  it "sets the source file on initialization" do
    @asm.source_file.must_equal(@filename)
  end

  it "can derive the target file from the source file" do
    @asm.target_file.must_equal("spec/fixtures/comment_only.hack")
  end

  it "defaults to using Assembler::InstructionParser for parsing" do
    @asm.parser.must_equal(Assembler::Parser)
  end

  describe "parsing & assembling a program" do
    before do
      @asm = Assembler.new(@filename, parser: TestParser, symboliser: TestSymboliser)
    end

    it "supports custom parsers" do
      @asm.parser.must_equal(TestParser)
      @asm.symboliser.must_equal(TestSymboliser)
    end

    it "can pass content through a parser" do
      content = File.read(@filename).lines.map(&:strip)
      @asm.parse(content).must_equal(content)
    end

    it "can pass content through a symboliser" do
      content = File.read(@filename).lines.map(&:strip)
      @asm.symbolise(content).must_equal(content.map { |l| "-- #{l}" })
    end

    it "writes the parsed and symbolised lines to the target file" do
      FileUtils.remove("spec/fixtures/comment_only.hack", force: true)

      @asm.assemble
      File.read("spec/fixtures/comment_only.hack").must_equal("--\n--\n--\n")
    end
  end
end
