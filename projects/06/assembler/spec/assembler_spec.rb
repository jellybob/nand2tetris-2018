require "assembler"

describe Assembler do
  class TestParser
    def initialize(file_contents)
      @contents = file_contents
    end

    def parse
      @contents
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
      @asm = Assembler.new(@filename, TestParser)
    end

    it "supports custom parsers" do
      @asm.parser.must_equal(TestParser)
    end

    it "passes the file contents to the parser, returning the parsed lines" do
      content = File.read(@filename).lines.map(&:strip)
      @asm.parse.must_equal(content)
    end

    it "writes the parsed lines to the target file" do
      FileUtils.remove("spec/fixtures/comment_only.hack", force: true)

      @asm.assemble
      File.read("spec/fixtures/comment_only.hack").must_equal(File.read("spec/fixtures/comment_only.asm"))
    end
  end
end
