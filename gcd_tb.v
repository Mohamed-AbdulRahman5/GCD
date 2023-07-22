`timescale 1ns/1ps


module gcd_tb();
  
  
  parameter op_sz=8 , clk_period=10;
  reg[op_sz-1:0] A,B;
                 reg start,clk=0,rst;
                 wire [op_sz-1:0] res;
                 wire done;
  
  
  gcd_top#(op_sz) top_unit
                ( A,B, start,clk,rst, res, done);
                
  
  
  always #(clk_period/2) clk=~clk;
  
  
  
  task calc (
   input [op_sz-1:0] A_tb,B_tb 
  );
    begin
    start =1;
    rst=1;
    A=A_tb;
    B=B_tb;
    #clk_period ;
    rst=0;
    wait(done)
    $display ("the GCD is %d",res); 
    #clk_period ;  
  end
  endtask
  
  initial
  begin
   calc(25,15);
   calc(12,9);
    calc(12,8);      
  end
  
  
  
  
endmodule
