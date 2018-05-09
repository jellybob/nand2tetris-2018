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
    it "can map a command to a binary integer" do
      parse("0").comp_as_binary.must_equal("0101010")
      parse("1").comp_as_binary.must_equal("0111111")
      parse("-1").comp_as_binary.must_equal("0111010")
      parse("D|A").comp_as_binary.must_equal("0010101")
      parse("M").comp_as_binary.must_equal("1110000")
      parse("D|M").comp_as_binary.must_equal("1010101")
    end
  end
end
