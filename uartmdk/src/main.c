#include "gw1ns4c.h"         
#include "gw1ns4c_uart.h"    
#include "gw1ns4c_syscon.h"  

// 把函数名改成 My_UART_SendString，避免和官方库同名冲突
void My_UART_SendString(UART_TypeDef* UARTx, char *str) {
    while (*str != '\0') {
        while (UARTx->STATE & 0x01); // 等待发送缓冲空
        UART_SendChar(UARTx, *str);  // 发送单个字符
        str++;
    }
}

int main(void) {
    UART_InitTypeDef UART_InitStruct;

    SystemInit(); 

    UART_InitStruct.UART_Mode.UARTMode_Tx = ENABLE;     
    UART_InitStruct.UART_Mode.UARTMode_Rx = ENABLE;     
    UART_InitStruct.UART_Int.UARTInt_Tx = DISABLE;      
    UART_InitStruct.UART_Int.UARTInt_Rx = DISABLE;      
    UART_InitStruct.UART_BaudRate = 115200;             

    UART_Init(UART0, &UART_InitStruct);

    while(1) {
        if (UART0->STATE & 0x02) { // 接收缓冲有数据
            
            uint8_t rx_data = (uint8_t)UART_ReceiveChar(UART0);
            
            // 调用我们自己改名后的发送字符串函数
            My_UART_SendString(UART0, "char is ");
            
            while (UART0->STATE & 0x01);
            UART_SendChar(UART0, rx_data);
            
            // 发送回车换行
            My_UART_SendString(UART0, "\r\n");
        }
    }
}
