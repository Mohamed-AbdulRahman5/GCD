




module gcd_top#(parameter op_sz=8) 
                (input [op_sz-1:0] A,B,
                 input start,clk,rst,
                 output [op_sz-1:0] res,
                 output done
                     );



wire [2:0] ctrl ;
wire [op_sz-1:0] A_reg,B_reg;
wire [op_sz-1:0] datapath_out;
wire cmp ;
  
  
  
  
  
  
  
  gcd_controller#(.op_sz(op_sz))  control_unit
                      (  .A(A),.B(B),.clk(clk),.rst(rst),.cmp(cmp),.start(start),
                      .datapath_out(datapath_out), .ctrl(ctrl),.res(res), .done(done),.A_reg(A_reg),.B_reg(B_reg) );



gcd_datapath#(.op_sz(op_sz)) datapath_unit(  .A(A_reg),.B(B_reg),.ctrl(ctrl),
                                      .out(datapath_out),.cmp(cmp));






endmodule