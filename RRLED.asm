


; PIC16F877 Configuration Bit Settings

; ASM source line config statements

#include "p16F877.inc"

; CONFIG
; __config 0xFF3A
 __CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_OFF & _HS_OSC &_WRT_ENABLE_ON & _LVP_OFF & _DEBUG_OFF & _CPD_OFF

org 0xaa
 
 main:
    ADDLW 8
    CLRF PORTD
    
    bsf PORTD,7
    BSF PORTD,5
    BSF PORTD,4
    CALL TIME
    
    RRF PORTD,1
 
    DECFSZ W,1
    GOTO main	
    GOTO exit
    
 TIME:
    
    RETURN
 


exit:
END


