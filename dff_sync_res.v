module dff_sync_res(D, clk, sync_reset, Q);
    input D;
    input clk;
    input sync_reset;
    output reg Q;

    // Your code goes here.  DO NOT change anything that is already given! Otherwise, you will not be able to pass the tests!

    wire w1, w2, w3, w4;
    nand_gate nand1(D, clk, w1);
    nand_gate nand2(~D, clk, w2);
    nand_gate nand3(w1, w4, w3); 
    nand_gate nand4(w3, w2, w4);
    always @(posedge clk or posedge sync_reset) begin
        if (sync_reset == 1) begin
        assign Q = 1'b0;
        end
        else begin
        assign Q = w3;
        end
    end

endmodule   

module nand_gate(w1, w2, out);

input w1, w2;
wire w3;
output out;
assign w3 = w1 && w2;
assign out = ~w3;
endmodule