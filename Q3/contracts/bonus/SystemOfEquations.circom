pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/comparators.circom";
include "../../node_modules/circomlib-matrix/circuits/matMul.circom"; // hint: you can use more than one templates in circomlib-matrix to help you
include "../../node_modules/circomlib-matrix/circuits/matSub.circom";

template SystemOfEquations(n) { // n is the number of variables in the system of equations
    signal input x[n]; // this is the solution to the system of equations
    signal input A[n][n]; // this is the coefficient matrix
    signal input b[n]; // this are the constants in the system of equations
    signal output out; // 1 for correct solution, 0 for incorrect solution

    component mult = matMul(n,n,1); // matrix multiplication component
    component sub = matSub(n,1); // matrix subrtaction component
    component zeroChk[n]; // declare zero check component

    // instantiate the zero check component
    for(var i=0;i<n;i++){
        zeroChk[i] = IsZero(); 
    }

    // multiply the coefficient matrix with the solution matrix (Ax=b)
    for(var i=0;i<n;i++){
        for(var j=0;j<n;j++){
            mult.a[i][j] <== A[i][j];
        }
        mult.b[i][0] <== x[i];
    }

    // subtract the constanst matrix(b) from the above 3x1 matrix(Ax)
    for(var i=0;i<n;i++){
        sub.a[i][0] <== mult.out[i][0];
        sub.b[i][0] <== b[i];
    }

    // Use the zeroCheck component to check if all the matrix has values are all 0s or 1s
    // all 0s indicate the solution is true otherwise its false
    var result=0;
    for(var i=0;i<n;i++){
        sub.out[i][0] ==> zeroChk[i].in;
        result *= zeroChk[i].out;
    }

    out <-- !result;

}

component main {public [A, b]} = SystemOfEquations(3);