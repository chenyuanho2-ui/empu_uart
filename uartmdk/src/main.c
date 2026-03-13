#include "gw1ns4c.h"         
#include "gw1ns4c_uart.h"    
#include "gw1ns4c_syscon.h"  

int main(void) {
    UART_InitTypeDef UART_InitStruct;

    // 1. 系统初始化
    SystemInit();

    // 2. 初始化 UART0
    UART_InitStruct.UART_Mode.UARTMode_Tx = ENABLE;     // 开启发送
    UART_InitStruct.UART_Mode.UARTMode_Rx = ENABLE;     // 开启接收
    UART_InitStruct.UART_Int.UARTInt_Tx = DISABLE;      // 轮询模式，关闭发送中断
    UART_InitStruct.UART_Int.UARTInt_Rx = DISABLE;      // 轮询模式，关闭接收中断
    UART_InitStruct.UART_BaudRate = 115200;             // 设置与电脑串口助手一致的波特率

    UART_Init(UART0, &UART_InitStruct);

    // 3. 进入主循环：轮询回环
    while(1) {
        // 检查 STATE 寄存器的第 1 位 (0x02)
        // 如果为真，说明 RX 缓冲区收到数据
        if (UART0->STATE & 0x02) {
            
            // 使用 4C 专用的接收函数读取数据
            uint8_t rx_data = (uint8_t)UART_ReceiveChar(UART0);

            // 检查 STATE 寄存器的第 0 位 (0x01)
            // 如果为 1，说明 TX 缓冲区正满，死等它把之前的数据发完
            while (UART0->STATE & 0x01);

            // 使用 4C 专用的发送函数把刚才读到的数据原样发回给电脑
            UART_SendChar(UART0, rx_data);
        }
    }
}
