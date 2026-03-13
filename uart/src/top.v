module top(
    input clk,
    input rst,

    input rx,
    output tx
);




wire [7:0] rdata;
reg [7:0] wdata;

reg wvalid;
reg rready;
wire wready;
wire rvalid;

reg [4:0] status;




uart UART1(
    .clk        (clk),
    .rst        (rst),

    .wdata_i    (wdata),
    .wvalid_i   (wvalid),
    .wready_o   (wready),
    .tx_o       (tx),

    .rx_i       (rx),
    .rready_i   (rready),
    .rvalid_o   (rvalid),
    .rdata_o    (rdata)
);


always @(posedge clk or negedge rst) begin
    if( !rst ) begin
        wdata <= 0;
        wvalid <= 0;
        status <= 0;
        rready <= 0;
    end else begin
        case(status)
            0: begin
                if(rvalid) begin
                    rready <= 1;
                    status <= status + 1;
                    wdata <= rdata;
                end
            end
            1: begin
                rready <= 0;
                
                wvalid <= 1;
                status <= status + 1;
            end
            2: begin
                if(wready) begin
                    wvalid <= 0;
                    status <= 0;
                end
            end
        endcase
    end

end

//always @(posedge clk or negedge rst) begin
//    if( !rst ) begin
//        wdata  <= 0;
//        wvalid <= 0;
//        status <= 0;
//    end else begin
//        case (status)
//            0 : begin
//                wdata  <= 8'h4f;
//                wvalid <= 1;
//                status <= status + 1;
//            end
//            1 : begin
//                if(wready) begin
//                    wvalid <= 0;
//                    status <= status + 1;
//                end
//            end
//            2 : begin
//                wdata  <= 8'h4b;
//                wvalid <= 1;
//                status <= status + 1;
//            end
//            3 : begin
//                if(wready) begin
//                    wvalid <= 0;
//                    status <= status + 1;
//                end
//            end
//            4 : begin
//                wdata  <= 8'h0d;
//                wvalid <= 1;
//                status <= status + 1;
//            end
//            5 : begin
//                if(wready) begin
//                    wvalid <= 0;
//                    status <= 0;
//                end
//            end
//        endcase
//    end
//end

endmodule
