require "assembler/parser"

describe Assembler::Parser::AInstruction do
  def parse(instruction)
    Assembler::Parser.new([]).parse_line(instruction)
  end

  describe "a valid A instruction" do
    before do
      @result = parse("@3")
    end

    it "sets the correct memory address" do
      @result.address.must_equal(3)
    end

    it "can assemble to binary correctly" do
      @result.to_s.must_equal("0000000000000011")
    end
  end

  describe "fuzzing" do
    it "can support arbitrary addresses" do
      {
        "@18" => "0000000000010010",
        "@24579" => "0110000000000011"
      }.each do |addr, encoding|
        parse(addr).to_s.must_equal(encoding)
      end
    end
  end

  describe "validation" do
    it "rejects a negative address" do
      -> { parse("@-1") }.must_raise Assembler::Parser::InvalidAddressError
    end
  end
end
