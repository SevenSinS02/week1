pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/comparators.circom";

template RangeProof(n) {
    assert(n <= 252);
    signal input in; // this is the number to be proved inside the range
    signal input range[2]; // the two elements should be the range, i.e. [lower bound, upper bound]
    signal output out;

    //components to check lesser equal than and greater equal than
    component low = LessEqThan(n);
    component high = GreaterEqThan(n);

    low.in[0] <== in;   // set number
    low.in[1] <== range[1]; // set upper bound

    high.in[0] <== in; // set number
    high.in[1] <== range[0]; //set lower bound
    
    // gives the result : 1 -> true, 0 -> false
    low.out * high.out ==> out;
}