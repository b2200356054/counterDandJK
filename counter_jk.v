module counter_jk(input reset, input clk, input mode, output [2:0] count);

    // Your code goes here.  DO NOT change anything that is already given! Otherwise, you will not be able to pass the tests!

    reg[2:0] wires;
    reg[1:0] previousStatesJKA;
    reg[1:0] previousStatesJKB;
    reg[1:0] previousStatesJKC;

    jk_sync_res jkA(previousStatesJKA[1], previousStatesJKA[0], clk, reset, count[2]);
    jk_sync_res jkB(previousStatesJKB[1], previousStatesJKB[0], clk, reset, count[1]);
    jk_sync_res jkC(previousStatesJKC[1], previousStatesJKC[0], clk, reset, count[0]);

    initial begin
        wires[2] = 1'b0;
        wires[1] = 1'b0;
        wires[0] = 1'b0;
        #15;
        forever begin
            wires[2] = count[2];
            wires[1] = count[1];
            wires[0] = count[0];
            #10;
        end
    end

    initial begin
        forever begin
            //COUNT IN BINARY
            if (mode == 1'b0) begin
                previousStatesJKA[1] = (wires[1] && wires[0]) ; //0 = C
                previousStatesJKA[0] = (wires[1] && wires[0]) ; //1 = B 2 = A
                
                previousStatesJKB[1] = (wires[0] && ~wires[1]) ;
                previousStatesJKB[0] = (wires[1] && wires[0]) ;

                previousStatesJKC[1] = (~wires[0]) ;
                previousStatesJKC[0] = (wires[0]) ;
                #10;
            end
            else begin
                previousStatesJKA[1] = (wires[1] && ~wires[0]) ;
                previousStatesJKA[0] = (~wires[1] && ~wires[0]) ;
                
                previousStatesJKB[1] = (wires[0] && ~wires[2]) ;
                previousStatesJKB[0] = (wires[2] && wires[0]) ;

                previousStatesJKC[1] = ((wires[1] && wires[2]) || (~wires[1] && ~wires[2])) ; 
                previousStatesJKC[0] = ((wires[1] && ~wires[2]) || (~wires[1] && wires[2])) ;
                #10;
            end 
        end
    end

endmodule