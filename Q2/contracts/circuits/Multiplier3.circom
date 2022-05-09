pragma circom 2.0.0;

//template for multiplication of two input signals num1,num2
template Multiplier2 (){
   signal input num1;
   signal input num2;
   signal output result;

   result <== num1*num2;
}

//composite circuit for multiplication of three input signals a,b,c
template Multiplier3 () {  

   // Declaration of signals.  
   signal input a; //first number 
   signal input b; //second number
   signal input c; //third number
   signal output d;  //multiplication output of 3 numbers

   // Multiplier2 components to mimic 2 gates of the circuit
   component G1 = Multiplier2();
   component G2 = Multiplier2();
   // Constraints.  
   a ==> G1.num1; //first input of gate1
   b ==> G1.num2; //second input of gate1
   G1.result ==> G2.num1; //result of gate1 is first input of gate2
   c ==> G2.num2; // the third signal is second input of gate 2
   G2.result ==> d; // the result of gate2 checked and assigned to output signal d
   
}

component main = Multiplier3();