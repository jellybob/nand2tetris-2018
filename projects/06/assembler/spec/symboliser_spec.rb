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

  it "resolves a label to an address" do
    @symboliser.symbolise(["D=A", "(LOOP)", "A=M"])
    @symboliser.symbols["LOOP"].must_equal(1)
  end

  it "finds the next empty space for an undefined address" do
    @symboliser.symbolise(["D=A", "@NAME", "A=M", "@FOO"])
    @symboliser.symbols["NAME"].must_equal(0x010)
    @symboliser.symbols["FOO"].must_equal(0x011)
  end

  it "always references a symbol to the same address" do
    @symboliser.symbolise(["D=A", "@NAME", "A=M", "@NAME", "@FOO"])
    @symboliser.symbols["NAME"].must_equal(0x010)
    @symboliser.symbols["FOO"].must_equal(0x011)
  end

  it "rewrites address symbols to addresses" do
    result = @symboliser.symbolise(["D=A", "(LOOP)", "A=M", "@LOOP"])
    result[3].must_equal("@1")
  end
end
