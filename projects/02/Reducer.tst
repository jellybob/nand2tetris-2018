load Reducer.hdl,
output-file Reducer.out,
compare-to Reducer.cmp,
output-list in%B1.16.1 out%B1.1.1;

set in %B0000000000000000,
eval,
output;

set in %B1111111111111111,
eval,
output;

set in %B1000000000000000,
eval,
output;

set in %B0000000000000001,
eval,
output;

set in %B0101010101010101,
eval,
output;
