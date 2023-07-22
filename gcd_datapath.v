


module gcd_datapath#(parameter op_sz=8)
                   (  input [op_sz-1:0] A,B,
                      input clk,rst,
                      input [2:0]ctrl,  
                      output reg [op_sz-1:0] out,
                      output reg cmp
                      

   );
  
   reg [op_sz-1:0] out,A_next,A_reg,B_next,B_reg;
   
  
  localparam cmp_eq=0 ,cmp_a =1 ,op_a=2 ,op_b=3 ,op_done=4 ;
  
 
 
 always(posedge clk)
 begin
 if(rst) begin
   A_reg<=0;
   B_reg<=0;
 end
 else
 
 
 
 end
 
 
 
 
 
 
 
  
  
  always@(*)
   begin
    cmp=A ;
    out =0;
    case(ctrl)
      cmp_eq : cmp = (A==B);
      cmp_a: cmp = (A>B)?1:0;
      op_a : out = A-B;
      op_b :out = B-A;
      op_done : out=A;
      default : begin 
        cmp=0 ;
       out =0;
        
      end
    endcase
  end
  
  
  
 
  
  
  
endmodule
