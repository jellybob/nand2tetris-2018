// Address of last block of pixels.
@24576
D=A
@R3
M=D

(RESET)
  @SCREEN
  D=A
  @R1
  M=D

(LOOP)
  @KBD
  D=M

  @WHITE
  D;JEQ

  // Set the next block to fully black
  (BLACK)
  @0
  D=A-1
  @FILL
  0;JMP

  (WHITE)
  @0
  D=A

  (FILL)
  @R1
  A=M
  M=D
  // Set the value of @NEXT
  D=A+1
  @R1
  M=D

  // Move to the next pixel, unless we've run
  // out of screen.
  @R3
  D=D-M
  @RESET
  D;JEQ

  @LOOP
  0;JMP
