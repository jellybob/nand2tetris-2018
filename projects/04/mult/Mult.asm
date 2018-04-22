// Zero the output
@R2
M=0

// Check that neither factor is 0,
// if it is we can bail early.
@R0
D=M
@END
D;JEQ

@R1
D=M
@END
D;JEQ

// Store how many loops we need.
@R0
D=M

@loops
M=D

(LOOP)
@R1
D=M

// Add second factor to the output.
@R2
MD=D+M

// Decrement loops, then check if they're
// at zero yet. If so, we're finished.
@loops
MD=M-1

@END
D;JEQ

// If not, loop again.
@LOOP
A;JMP

(END)
0;JMP
