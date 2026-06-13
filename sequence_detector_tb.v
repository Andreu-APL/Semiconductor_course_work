module sequence_detector_tb();

reg clk; 
reg rst; 
reg sequence_in; 
wire sequence_out; 

sequence_detector DUT( 
    .clk(clk),
    .rst(rst),
    .sequence_in(sequence_in),
    .sequence_out(sequence_out)
);

always #5 clk = ~clk; 

initial begin
    clk=0; 
    rst=1; 
    sequence_in=0;

    #10; 

    rst = 0;
    
    //hacemos la prueba con la secuencia solicitada 11010
    sequence_in= 1; 
    #10; 
    sequence_in= 1; 
    #10; 
    sequence_in=0; 
    #10; 
    sequence_in=1; 
    #10; 
    sequence_in=0;
    #10;

    $finish;
end


initial begin 
    $monitor("rst=%b | sequence_in=%b | sequence_out=%b",rst,sequence_in,sequence_out); 
end 

 initial begin
        $dumpfile("sequence_detector_tb.vcd");
        $dumpvars(0, sequence_detector_tb);
    end

endmodule
