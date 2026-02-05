module ss_pipeline_reg_fsm (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [5:0] in_data,
    input  logic        in_valid,
    output logic        in_ready,
    output logic [5:0] out_data,
    output logic        out_valid,
    input  logic        out_ready
);

    always_ff @(posedge clk or negedge rst_n) begin    //asynchrnous reset is preffered over synchronous reset -good practise
        if (!rst_n) begin
            out_valid <= 1'b0;
            out_data  <= 6'h0;
        end
        else begin
            if (in_ready) begin
                out_valid <= in_valid;
                if (in_valid) begin
                    out_data <= in_data;   //lock data only if both in_valid and in_ready are asserted
                end
            end
        end
    end
    assign in_ready = ~out_valid || out_ready;  //the producer is ready to send data only is the consumer is ready to consume data or when  no data is being processed or valid is 0

endmodule

