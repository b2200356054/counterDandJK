module counter_d(input reset, input clk, input mode, output [2:0] count);

    // Your code goes here.  DO NOT change anything that is already given! Otherwise, you will not be able to pass the tests!
    
    wire[2:0] previousStates;
    reg[2:0] previousStatesGrayCode;
    reg[2:0] wires;
    wire[6:0] wires_2; 
    wire[5:0] wires_2_1;
    wire[3:0] wires_1_1;
    wire wires_2_out;
    wire wires_2_really_out;
    wire[4:0] wires_1;
    wire wires_1_out;
    wire wires_1_really_out;
    wire[2:0] wires_0;
    wire[3:0] wires_0_1;
    wire wires_1_actual_out;
    wire wires_0_out;
    wire not_mode;
    dff_sync_res D_A(previousStates[2], clk, reset, count[2]);
    dff_sync_res D_B(previousStates[1], clk, reset, count[1]);
    dff_sync_res D_C(previousStates[0], clk, reset, count[0]);
    not_gate not0(not_mode, mode);
    //COUNT IN BINARY
    //previousStates[2] = ((~wires[0] && wires[2]) || (wires[2] && ~wires[1]) || (~wires[2] && wires[1] && wires[0]));
    not_gate n1(wires_2[0], wires[0]); //NOT WIRES0
    and_gate and1(wires_2[1], wires_2[0], wires[2]); //FIRST TERM ENDED wires_2[1] is the result;

    not_gate n2(wires_2[2], wires[1]); //NOT WIRES1
    and_gate and2(wires_2[3], wires_2[2], wires[2]); //SECOND TERM ENDED wires_2[3] is the result;

    not_gate n3(wires_2[4], wires[2]); //NOT WIRES2
    and_gate and3(wires_2[5], wires_2[4], wires[1]);
    and_gate and4(wires_2[6], wires_2[5], wires[0]); //THIRD TERM ENDED wires_2[6] is the result;

    or_gate or1(wires_2_out, wires_2[6], wires_2[3]);
    or_gate or2(wires_2_really_out, wires_2_out, wires_2[1]); //SUM OF THE PRODUCTS

    and_gate and11(wires_2_actual_out, wires_2_really_out, not_mode);


    //previousStates[1] = ((wires[1] && ~wires[0]) || (~wires[1] && wires[0]));
    not_gate n4(wires_1[0], wires[0]);
    and_gate and5(wires_1[1], wires[1], wires_1[0]); //FIRST TERM ENDED

    not_gate n5(wires_1[2], wires[1]);
    and_gate and6(wires_1[3], wires_1[2], wires[0]);

    or_gate or4(wires_1_really_out, wires_1[3], wires_1[1]);
    and_gate andDontKnow(wires_1_actual_out, wires_1_really_out, not_mode);
    

    //previousStates[0] = (~wires[0]);

    not_gate n6(wires_0_out, wires[0]);
    and_gate and10(wires_0_out_out, wires_0_out, not_mode);
    
    //BINARY ENDED





    //GRAYCODE
    //previousStates[0] = (((~wires[2]) && (~wires[1])) || (wires[2] && wires[1]));

    and_gate andGray1(wires_0_1[0], wires_2[2], wires_2[4]); //FIRST TERM
    
    and_gate andGray2(wires_0_1[1], wires[2], wires[1]);

    or_gate orGray1(wires_0_1[2], wires_0_1[0], wires_0_1[1]);

    and_gate andGray4(wires_0_1[3], wires_0_1[2], mode);
    
    //previousStates[1] = ((wires[1] && (~wires[0])) || (wires[0] && (~wires[2])));
    
    and_gate andGray5(wires_1_1[0], wires[1], wires_2[0]);//FIRST TERM

    and_gate andGray6(wires_1_1[1], wires[0], wires_2[4]);

    or_gate orGray2(wires_1_1[2], wires_1_1[0], wires_1_1[1]);

    and_gate andGray7(wires_1_1[3], wires_1_1[2], mode);

    //previousStates[2] = ((wires[1] && (~wires[0])) || (wires[2] && (wires[0])) || (wires[2] && wires[1]));

    and_gate andGray11(wires_2_1[0], wires[1], wires_2[0]); //first term

    and_gate andGray12(wires_2_1[1], wires[2], wires[0]); //SECOND TERM

    and_gate andGray13(wires_2_1[2], wires[2], wires[1]); //THIRD TERM

    or_gate orGray14(wires_2_1[3], wires_2_1[2], wires_2_1[1]); //THIRD AND SECOND

    or_gate orgGray15(wires_2_1[4], wires_2_1[3], wires_2_1[0]); //ALL TOGETHER

    and_gate andGray123(wires_2_1[5], wires_2_1[4], mode);

    
    or_gate orFinal0(previousStates[0], wires_0_1[3], wires_0_out_out); //LSB 
    or_gate orFinal1(previousStates[1], wires_1_actual_out, wires_1_1[3]);
    or_gate orFinal2(previousStates[2], wires_2_actual_out, wires_2_1[5]);

    initial begin
        wires[0] = 1'b0;
        wires[1] = 1'b0;
        wires[2] = 1'b0;
        #15;
        forever begin
            wires[2] = count[2];
            wires[1] = count[1];
            wires[0] = count[0];
            #10;
        end
    end

    initial begin
        #4000;
        $finish;
    end

        
endmodule

module and_gate(Y, A, B);
    input A, B;
    output Y;

    assign Y = A && B;
endmodule

module not_gate(Y, A);
    input A;
    output Y;

    assign Y = ~A;

endmodule

module or_gate(Y, A, B);
input A, B;
output Y;
assign Y = A || B;

endmodule