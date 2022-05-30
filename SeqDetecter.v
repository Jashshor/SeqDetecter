module SeqDetecter(
      input x,
        input clk,
        input rst,
        output reg judge
);
reg[2:0] CS;
reg[2:0] NS;
//Binary Gray Code for state
parameter IDLE=3'b000;
parameter S1=3'b001;
parameter S2=3'b011;
parameter S3=3'b010;
parameter S4=3'b110;
parameter S5=3'b111;

initial
begin
judge=1'b0;
end

always@(posedge clk or negedge rst)
begin
    if(rst==1'b0)
    begin
        CS<=NS;
    end
    else begin
        CS<=IDLE;
    end
end

always@(CS or x)
begin
    case(CS)
        IDLE:
            if(x==1'b1) NS<=S1;
            else NS<=IDLE;
        S1:
        begin
            judge<=1'b0;
            if(x==1'b1) NS<=S1;
            else NS<=S2;
        end
        S2:
        begin
            judge<=1'b0;
            if(x==1'b1) NS<=S1;
            else NS<=S3;
        end
        S3:
            if(x==1'b1) NS<=S4;
            else NS<=IDLE;
        S4:
        begin
            judge<=1'b1;
            if(x==1'b1) NS<=S1;
            else NS<=S2;
        end
    endcase
end

endmodule