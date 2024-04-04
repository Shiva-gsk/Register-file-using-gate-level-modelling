module RF8_4b_GL
   (
     input  wire [2:0]  wrAddr,  //ip to one decoder
     input  wire [3:0]  wrVal,   //ip to D reg file
     input  wire        wrEn,     //ip to en of D reg file
     input  wire [2:0]  rdAddr,  //ip to second decoder
     output wire [3:0]  rdVal,   //line to op q of d reg file
     input  wire clk             //clock to d reg  
    );

  wire n0,n1,n2,n3,n4,n5,n6,n7; 
  wire [3:0] reg0;
  wire [3:0] reg1;
  wire [3:0] reg2;
  wire [3:0] reg3;
  wire [3:0] reg4;
  wire [3:0] reg5;
  wire [3:0] reg6 ;
  wire [3:0] reg7;

  Decoder_GL unit0(.Y7(n7),.Y6(n6),.Y5(n5),.Y4(n4),.Y3(n3),.Y2(n2),.Y1(n1),.Y0(n0),.A(wrAddr[2]),.B(wrAddr[1]),.C(wrAddr[0]),.En(wrEn));

  //regfile (Q,D,CK,En);
  //1st Row
  regfile r00(reg0[3],wrVal[3],clk,n0);
  regfile r01(reg0[2],wrVal[2],clk,n0);
  regfile r02(reg0[1],wrVal[1],clk,n0);
  regfile r03(reg0[0],wrVal[0],clk,n0);

  //2nd Row
  regfile r10(reg1[3],wrVal[3],clk,n1);
  regfile r11(reg1[2],wrVal[2],clk,n1);
  regfile r12(reg1[1],wrVal[1],clk,n1);
  regfile r13(reg1[0],wrVal[0],clk,n1);

  //3rd Row
  regfile r20(reg2[3],wrVal[3],clk,n2);
  regfile r21(reg2[2],wrVal[2],clk,n2);
  regfile r22(reg2[1],wrVal[1],clk,n2);
  regfile r23(reg2[0],wrVal[0],clk,n2);

  //4th Row
  regfile r30(reg3[3],wrVal[3],clk,n3);
  regfile r31(reg3[2],wrVal[2],clk,n3);
  regfile r32(reg3[1],wrVal[1],clk,n3);
  regfile r33(reg3[0],wrVal[0],clk,n3);

  //5th Row
  regfile r40(reg4[3],wrVal[3],clk,n4);
  regfile r41(reg4[2],wrVal[2],clk,n4);
  regfile r42(reg4[1],wrVal[1],clk,n4);
  regfile r43(reg4[0],wrVal[0],clk,n4);

  //6th Row
  regfile r50(reg5[3],wrVal[3],clk,n5);
  regfile r51(reg5[2],wrVal[2],clk,n5);
  regfile r52(reg5[1],wrVal[1],clk,n5);
  regfile r53(reg5[0],wrVal[0],clk,n5);

  //7th Row
  regfile r60(reg6[3],wrVal[3],clk,n6);
  regfile r61(reg6[2],wrVal[2],clk,n6);
  regfile r62(reg6[1],wrVal[1],clk,n6);
  regfile r63(reg6[0],wrVal[0],clk,n6);

  //8th Row
  regfile r70(reg7[3],wrVal[3],clk,n7);
  regfile r71(reg7[2],wrVal[2],clk,n7);
  regfile r72(reg7[1],wrVal[1],clk,n7);
  regfile r73(reg7[0],wrVal[0],clk,n7);

endmodule
//register module
module regfile (Q,D,CK,En);
  input D,CK,En;
  output Q;

  wire mout;
  mux21 m1(mout,En,Q,D);
  dff d1(Q,CK,mout);

endmodule

//mux 2:1 
module mux21(Ymux,Smux,Imux0,Imux1);
output Ymux;
input Smux,Imux0,Imux1;

wire smux,mx0,mx1;

    not_gate not1(smux,Smux);
    and1 not2(mx0,Imux0,smux);
    and1 not3(mx1,Imux1,Smux);
    or1 not4(Ymux,mx0,mx1);
endmodule

//D FlipFlop
module dff(Q,clk,D);
  input D, clk;
  output Q;

  wire m0,m1,m2,m3,qb;

  nand_gate2 t1(m2,m1,m0);
  nand_gate2 t2(m1,m2,clk);
  nand_gate3 t3(m3,m0,m1,clk);
  nand_gate2 t4(m0,m3,D);
  nand_gate2 t5(Q,m1,qb);
  nand_gate2 t6(qb,Q,m3);
endmodule

module Decoder_GL(Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0,A,B,C,En);
  input A,B,C,En;
  output Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0;

  wire ab,bb,cb;

not_gate oo1(ab,A);
not_gate oo2(bb,B);
not_gate oo3(cb,C);

and4 oo4(Y0,En,ab,bb,cb);
and4 oo5(Y1,En,ab,bb,C);
and4 oo6(Y2,En,ab,B,cb);
and4 oo7(Y3,En,ab,B,C);
and4 oo8(Y4,En,A,bb,cb);
and4 oo9(Y5,En,A,bb,C);
and4 oo10(Y6,En,A,B,cb);
and4 oo11(Y7,En,A,B,C);

endmodule

module nand_gate3(D1,A1,B1,C1);
  output D1;
  input A1,B1,C1;

  wire n01, n11;

  nand_gate2 i1(n01,A1,B1);
  not_gate i2(n11,n01);
  nand_gate2 i3(D1,C1,n11);
endmodule

module nand_gate2
  (
   Y, A, B
   );
   output Y;
   input  A;
   input  B;

   nand(Y, A, B);
endmodule


module and1(otp,in1,in2);
  output otp;
  input in1,in2;
  wire otp1;

  nand2 i101(otp1,in1,in2);
  not_gate i202(otp,otp1);

endmodule

module or1(outp,in3,in4);
  output outp;
  input in3,in4;
  wire otp1;

  nor_gate i10101(otp1,in3,in4);
  not_gate i20202(outp,otp1);

endmodule

module not_gate
  (
   Y, A
   );
   output Y;
   input  A;

   not(Y,A);

endmodule



module xor_gate2
  (
   Y, A, B
   );

  output Y;
  input  A;
  input  B;

  xor(Y, A, B);

endmodule

module nand2
  (
   Y, A, B
   );
   output Y;
   input  A;
   input  B;

   nand(Y, A, B);
endmodule

module nor_gate
  (
   Y, A, B
   );
   output Y;
   input  A;
   input  B;

   nor(Y, A, B);
endmodule
