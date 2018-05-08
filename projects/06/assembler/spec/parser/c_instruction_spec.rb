require "assembler/parser"

describe Assembler::Parser::CInstruction do
  def parse(instruction)
    Assembler::Parser.new([]).parse_line(instruction)
  end

  describe "parsing the destination" do
    it "supports no destination" do
      r = parse("0")
      r.dest_as_binary.must_equal("000")
    end

    it "supports M" do
      r = parse("M=0")
      r.dest_as_binary.must_equal("001")
    end

    it "supports D" do
      r = parse("D=0")
      r.dest_as_binary.must_equal("010")
    end

    it "supports MD" do
      r = parse("MD=0")
      r.dest_as_binary.must_equal("011")
    end

    it "supports A" do
      r = parse("A=0")
      r.dest_as_binary.must_equal("100")
    end

    it "supports AM" do
      r = parse("AM=0")
      r.dest_as_binary.must_equal("101")
    end

    it "supports AD" do
      r = parse("AD=0")
      r.dest_as_binary.must_equal("110")
    end

    it "supports AMD" do
      r = parse("AMD=0")
      r.dest_as_binary.must_equal("111")
    end
  end

  describe "parsing the computation" do
    it "suports 0" do
      r = parse("0")
      r.comp_as_binary.must_equal("101010")
    end

    it "supports 1" do
      r = parse("1")
      r.comp_as_binary.must_equal("111111")
    end

    it "supports -1"

    it "supports D" do
      r = parse("D")
      r.comp_as_binary.must_equal("001100")
    end
  end
end
