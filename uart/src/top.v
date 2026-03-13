module top(
    input  wire clk,  // 对应约束里的 27MHz 时钟 (Pin 45)
    input  wire rst,  // 对应约束里的复位按键 (Pin 15)
    input  wire rx,   // 对应约束里的串口接收 (Pin 44)
    output wire tx    // 对应约束里的串口发送 (Pin 46)
);

    // 注意：这里的模块名 Gowin_EMPU_Top 如果和你刚才生成的不同，请改成你实际生成的模块名
    Gowin_EMPU_Top empu_inst (
        .sys_clk    (clk),       
        .reset_n    (rst),       
        .uart0_rxd  (rx),        
        .uart0_txd  (tx)         
    );

endmodule