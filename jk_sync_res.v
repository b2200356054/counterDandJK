module jk_sync_res(J, K, clk, sync_reset, Q);
    input J;
    input K;
    input clk;
    input sync_reset;
    output reg Q;

    // Your code goes here.  DO NOT change anything that is already given! Otherwise, you will not be able to pass the tests!

   initial begin
        Q = 0;
    end
    
    always @(posedge clk) begin
        begin
            if (sync_reset == 1'b1)
            Q <= 1'b0;
            else
                case({J, K})
                    2'b00 : Q <= Q;
                    2'b01 : Q <= 0;
                    2'b10 : Q <= 1;
                    2'b11 : Q <= ~Q;
                endcase
        end
    end

endmodule