`timescale 1ns/1ps

module counter_tb;
    reg reset, clk, mode; 
    wire [2:0] count;
    integer i;
	
	//Comment the next line out when testing your JK flip flop implementation.
    counter_d uut(reset, clk, mode, count);
    // Uncomment the next line to test your JK flip flop implementation.
     //counter_jk c1(reset, clk, mode, count);

    initial begin
        // Your code goes here.  DO NOT change anything that is already given! Otherwise, you will not be able to pass the tests!
        // Make sure to use $finish statement to avoid infinite loops.
        mode = 1'b0;
        #2000;
        mode = 1'b1;
        #2000;
        $display("Test is completed.");
        $finish;
    end

    initial begin

        // Generate clock
        // Your code goes here.  DO NOT change anything that is already given! Otherwise, you will not be able to pass the tests!

        clk = 1'b0;
        forever begin
            #10;
            clk = ~clk;
        end
    end

    initial begin
        $dumpfile("counter_tb.vcd");
        $dumpvars(0, counter_tb);
        forever begin
            reset = 1'b0;
            #500;
            reset = 1'b1;
            #25;
            reset = 1'b0;
        end
    end

endmodule