module sequence_detector( 
    input clk, rst, 
    input sequence_in, 
    output reg sequence_out
); 

parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5; 

reg [2:0] state, next_state;

always @(posedge clk or posedge rst) begin 
    if (rst) 
        state <= S0; 
    else 
        state <= next_state; 
end

// 11010
always @(*) begin 
    case (state) 

        S0 : begin 
            if (sequence_in) 
                next_state = S1; 
            else 
                next_state = S0; 

            sequence_out = 0;
        end 

        S1 : begin 
            if (sequence_in) 
                next_state = S2; 
            else
                next_state = S0; 

            sequence_out = 0;
        end 

        S2 : begin 
            if (sequence_in)
                next_state = S2; 
            else 
                next_state = S3;

            sequence_out = 0;  
        end 

        S3 : begin 
            if (sequence_in)
                next_state = S4; 
            else 
                next_state = S0; 

            sequence_out = 0;
        end 

        S4 : begin  
            if (sequence_in)
                next_state = S2; 
            else 
                next_state = S5; 

            sequence_out = 0; 
        end

        S5 : begin 
            if (sequence_in)
                next_state = S1; 
            else 
                next_state = S0; 

            sequence_out = 1; 
        end
        
        default : begin 
            next_state = S0; 
            sequence_out = 0; 
        end 

    endcase 
end 

endmodule
