






0000000000000000
D=M              // D = first number
0000000000000001
D=D-M            // D = first number - second number
0000000000010000
D;JGT            // if D>0 (first is greater) goto output_first
0000000000000001
D=M              // D = second number
0000000000010001
0;JMP            // goto output_d
(OUTPUT_FIRST)
0000000000000000
D=M              // D = first number
(OUTPUT_D)
0000000000000010
M=D              // M[2] = D (greatest number)
(INFINITE_LOOP)
0000000000010000
0;JMP            // infinite loop
