//register module
module regfile (Q,D,CK,En);
  input D,CK,En;
  output Q;

  wire mout;
  mux21 m1(mout,En,Q,D);
  dff d1(Q,CK,mout);

endmodule

//mux
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

