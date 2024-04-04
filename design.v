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
  MUX8_4b_GL unit1(.A0(qrow0),.A1(qrow1),.A2(qrow2),.A3(qrow3),.A4(qrow4),.A5(qrow5),.A6(qrow6),.A7(qrow7),.S(rdAddr),.Y(rdVal));

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

module MUX8_4b_GL
   (
     input  wire [3:0] A0,
     input  wire [3:0] A1,
     input  wire [3:0] A2,
     input  wire [3:0] A3,
     input  wire [3:0] A4,
     input  wire [3:0] A5,
     input  wire [3:0] A6,
     input  wire [3:0] A7,
     input  wire [2:0] S,
     output wire [3:0] Y  );

 // wire s2 = S[2]; wire s1 = S[1] ;wire s0 = S[0] //Select inputs
    wire s2b, s1b, s0b;                    //~Select inputs
    wire a00_out,a01_out,a02_out,a03_out;  //A0 all out
    wire a10_out,a11_out,a12_out,a13_out;  //A1 all out
    wire a20_out,a21_out,a22_out,a23_out;  //A2 all out
    wire a30_out,a31_out,a32_out,a33_out;  //A3 all out
    wire a40_out,a41_out,a42_out,a43_out;  //A4 all out
    wire a50_out,a51_out,a52_out,a53_out;  //A5 all out
    wire a60_out,a61_out,a62_out,a63_out;  //A6 all out
    wire a70_out,a71_out,a72_out,a73_out;  //A7 all out



  not_gate inv1g1 (s0b,S[0]);
  not_gate inv2g2 (s1b,S[1]);
  not_gate inv3g3 (s2b,S[2]);

  //for A0
  and_logic and01 (a00_out,A0[0],s0b,s1b,s2b);
  and_logic and02 (a01_out,A0[1],s0b,s1b,s2b);
  and_logic and03 (a02_out,A0[2],s0b,s1b,s2b);
  and_logic and04 (a03_out,A0[3],s0b,s1b,s2b);

  //for A1
  and_logic and11 (a10_out,A1[0],s2b,s1b,S[0]);
  and_logic and12 (a11_out,A1[1],s2b,s1b,S[0]);
  and_logic and13 (a12_out,A1[2],s2b,s1b,S[0]);
  and_logic and14 (a13_out,A1[3],s2b,s1b,S[0]);

  //for A2
  and_logic and21 (a20_out,A2[0],s2b,S[1],s0b);
  and_logic and22 (a21_out,A2[1],s2b,S[1],s0b);
  and_logic and23 (a22_out,A2[2],s2b,S[1],s0b);
  and_logic and24 (a23_out,A2[3],s2b,S[1],s0b);

  //for A3
  and_logic and31 (a30_out,A3[0],s2b,S[1],S[0]);
  and_logic and32 (a31_out,A3[1],s2b,S[1],S[0]);
  and_logic and33 (a32_out,A3[2],s2b,S[1],S[0]);
  and_logic and34 (a33_out,A3[3],s2b,S[1],S[0]);

  //for A4
  and_logic and41 (a40_out,A4[0],S[2],s1b,s0b);
  and_logic and42 (a41_out,A4[1],S[2],s1b,s0b);
  and_logic and43 (a42_out,A4[2],S[2],s1b,s0b);
  and_logic and44 (a43_out,A4[3],S[2],s1b,s0b);

  //for A5
  and_logic and51 (a50_out,A5[0],S[2],s1b,S[0]);
  and_logic and52 (a51_out,A5[1],S[2],s1b,S[0]);
  and_logic and53 (a52_out,A5[2],S[2],s1b,S[0]);
  and_logic and54 (a53_out,A5[3],S[2],s1b,S[0]);

  //for A6
  and_logic and61 (a60_out,A6[0],S[2],S[1],s0b);
  and_logic and62 (a61_out,A6[1],S[2],S[1],s0b);
  and_logic and63 (a62_out,A6[2],S[2],S[1],s0b);
  and_logic and64 (a63_out,A6[3],S[2],S[1],s0b);

  //for A7
  and_logic and71 (a70_out,A7[0],S[2],S[1],S[0]);
  and_logic and72 (a71_out,A7[1],S[2],S[1],S[0]);
  and_logic and73 (a72_out,A7[2],S[2],S[1],S[0]);
  and_logic and74 (a73_out,A7[3],S[2],S[1],S[0]);

  //for 0th bit
  or_logic oplog0 (Y[0],a00_out,a10_out,a20_out,a30_out,a40_out,a50_out,a60_out,a70_out);
  //for 1st bit
  or_logic oplog1 (Y[1],a01_out,a11_out,a21_out,a31_out,a41_out,a51_out,a61_out,a71_out);
  //for 2nd bit
  or_logic oplog2 (Y[2],a02_out,a12_out,a22_out,a32_out,a42_out,a52_out,a62_out,a72_out);
  //for 3rd bit
  or_logic oplog3 (Y[3],a03_out,a13_out,a23_out,a33_out,a43_out,a53_out,a63_out,a73_out);

endmodule


module and_logic(and_out,w,x,y,z);
  //input is select signal of 3 bits to w,x,y and our bit input An[0].
  //output and_out goes to the or gate for final stage.  
  input w,x,y,z;
  output and_out;
  wire pe1, pe2;

  and1 an1(pe1,w,x);
  and1 an2(pe2,y,z);
  and1 an3(and_out,pe1,pe2);

endmodule

//for and_logic all ouputs of and_logic element to final Y[0]
module or_logic(or_logic_op,g,h,i,j,k,l,m,n);
  input g,h,i,j,k,l,m,n;
  output or_logic_op;

  wire orlog1,orlog2,orlog3,orlog4,orlog5,orlog6;

  or1 lo1(orlog1,g,h);
  or1 lo2(orlog2,i,j);
  or1 lo3(orlog3,k,l);
  or1 lo4(orlog4,m,n);
  or1 lo5(orlog5,orlog1,orlog2);
  or1 lo6(orlog6,orlog3,orlog4);
  or1 lo7(or_logic_op,orlog5,orlog6);

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
