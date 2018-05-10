require "assembler/symboliser"

describe Assembler::Symboliser do
  before do
    @symboliser = Assembler::Symboliser.new
  end

  it "initializes with a clone of the default symbol table" do
    @symboliser.symbols.must_equal(Assembler::Symboliser::DEFAULT_SYMBOLS)
    @symboliser.frozen?.must_equal(false)
  end

  it "initializes the symbol table at position 16" do
    @symboliser.next_free.must_equal(0x010)
  end

  it "initializes the instruction position at 0" do
    @symboliser.next_instruction.must_equal(0)
  end

  describe "incrementing the instruction counter" do
    it "increments for instruction lines" do
      @symboliser.symbolise(["D=A", "A=M"])
      @symboliser.next_instruction.must_equal(2)
    end

    it "does not increment for labels" do
      @symboliser.symbolise(["D=A", "(LOOP)", "A=M"])
      @symboliser.next_instruction.must_equal(2)
    end

    it "does not increment for comments" do
      @symboliser.symbolise(["D=A", "// Comment", "A=M"])
      @symboliser.next_instruction.must_equal(2)
    end
 end
end
