



module gcd_controller#(parameter op_sz=8) 
                      ( input [op_sz-1:0] A,B,
                        input clk,rst,cmp,start,
                        input [op_sz-1:0] datapath_out,
                        output reg [2:0]ctrl,  
                        output reg [op_sz-1:0] res,
                        output reg done,
                        output reg [op_sz-1:0] A_reg,B_reg
                       
                      );
  
  
  
  localparam start_s=0, check_eq=1,check_a=2,
              op_a =3,op_b=4 ,op_done =5;
              
             
  
  
  
       reg  [op_sz-1:0] A_next,B_next,res_next; // to register the output
       reg [2:0]ctrl_next;             
       reg [2:0] state_reg ,state_next ;
       reg done_next;
     
     
     
     
     //registers block
       always@(posedge clk)
       begin
         if(rst) begin
           state_reg <=start_s ;
           A_reg <= 0;
           B_reg <=0;
           ctrl<=0;
           res<=0;
           done<=0;                              
       end
     else begin
        state_reg <=state_next ;
           A_reg <= A_next;
           B_reg <=B_next;
           ctrl<=ctrl_next;
           res<=res_next;
           done<= done_next;                        
     end
     end
  
  
  
  
  
  /// next state block
  always@(*)
  begin
  state_next= start_s ;
  A_next = A_reg;
  B_next = B_reg;
  ctrl_next=0;
  res_next=res;
  done_next=0;  
    case(state_reg)
      //////////first state check to start/////////////
     start_s :begin   
      if(start)begin
        state_next =check_eq; 
        ctrl_next =0;
        res_next=0;
         A_next = A;
         B_next = B;  
      end
    else begin 
       state_next =start_s; 
    end      
   end 
   /////////////check if equal state /////////////////////
    check_eq: begin
          if(cmp)begin
            state_next = op_done;
            ctrl_next=4;
           // done_next =1;
         //   res_next = datapath_out ;
          end
        else begin
          state_next = check_a;
          ctrl_next=1;
        end
    end
    /////////////check is A bigger state //////////////////////
    check_a : begin
         
         if(cmp)begin           
              state_next = op_a;
              ctrl_next=2;
             //  A_next = datapath_out;  
              end
         else begin          
           state_next = op_b;
            ctrl_next=3;
           // B_next = datapath_out;  
         end

    end
    /////////////////////op on a state/////////////////////////////
    op_a: begin
      state_next =check_eq;
      ctrl_next =0;
      A_next = datapath_out;
           end
    
    //////////////////op on b/////////////////////////////////////
     op_b: begin
       state_next =check_eq;
       ctrl_next =0;
        B_next = datapath_out;
         end
    ///////////////////done state//////////////////////////////
    op_done: begin
       state_next =start_s; 
       done_next =1;
        res_next = datapath_out ;
    end   
 endcase 
  end
  
  
  
  
  
//  //// output state
//  always@(*)
//  begin
//  A_next = A_reg;
//  B_next = B_reg;
//  ctrl_next=0;
//  res_next=0;
//  done_next=0;  
//    case(state_next)
//      //////////first state check to start/////////////
//     start_s :begin   
//         A_next = A;
//         B_next = B;
//      ctrl_next=0;     
//      end
//
//   /////////////check if equal state /////////////////////
//    check_eq: begin
//         A_next = A_reg; 
//      B_next = B_reg;  
//            ctrl_next = 0;  end
//
//    /////////////check is A bigger state //////////////////////
//    check_a : begin
//               
//           ctrl_next=1;
//              
//         end
//
//
//    /////////////////////op on a state/////////////////////////////
//    op_a: begin
//     
//          ctrl_next=2;
//          A_next= A_reg-B_reg; end
//    
//    //////////////////op on b/////////////////////////////////////
//     op_b: begin
//      
//          ctrl_next=3;
//          B_next= B_reg-A_reg; end
//    ///////////////////done state//////////////////////////////
//    op_done: begin
//      done_next =1;
//      res_next = datapath_out ;
//    end   
// endcase 
//  end
//  
  
  
endmodule
