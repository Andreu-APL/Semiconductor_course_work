module sequence_detector_11010 (
    input  clk,
    input  rst,
    input  sequence_in,
    output reg match_sequence
);

    localparam [2:0] S_IDLE  = 3'd0;
    localparam [2:0] S_1     = 3'd1;
    localparam [2:0] S_11    = 3'd2;
    localparam [2:0] S_110   = 3'd3;
    localparam [2:0] S_1101  = 3'd4;
    localparam [2:0] S_11010 = 3'd5;

    reg [2:0] state, next;

    always @(*) begin
        case (state)
            S_IDLE  : next = sequence_in ? S_1     : S_IDLE;
            S_1     : next = sequence_in ? S_11    : S_IDLE;
            S_11    : next = sequence_in ? S_11    : S_110;
            S_110   : next = sequence_in ? S_1101  : S_IDLE;
            S_1101  : next = sequence_in ? S_11    : S_11010;
            S_11010 : next = sequence_in ? S_1     : S_IDLE;
            default : next = S_IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (rst)
            state <= S_IDLE;
        else
            state <= next;
    end

    always @(*) begin
        match_sequence = (state == S_11010);
    end

endmodule
