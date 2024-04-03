//register module
module regfile (Q,D,CK,En);
  input D,CK,En;
  output Q;

  wire mout;
  mux21 m11(mout,En,Q,D);
  dff d11(Q,CK,mout);

endmodule
