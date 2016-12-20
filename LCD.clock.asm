 LIST 	P=PIC16F877
#include <P16f877.inc>

 __CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_OFF & _HS_OSC & _WRT_ENABLE_ON & _LVP_OFF & _DEBUG_ON & _CPD_OFF

#include "BCD_adapter.inc"
#include "LCD_Functions.inc"
   
 ORG 0X00

RESET:
    CALL INITDisplay
    CALL FORMAT.TIME;FORMAT FUNCTION ON SCREEN AND INIT VARIABALE 
    
TIMERLOGIC:
    
INIT.VAL:
    
    MOVLW 0X3B ;-------->SET.SECONDS
    MOVWF 0X52
    CALL BCD.2.DIG
    MOVLW 0XCA
    CALL PRINT.TIME
    
    
    MOVLW 0X3B ;-------->SET.MINTUES
    MOVWF 0X53
    CALL BCD.2.DIG
    MOVLW 0XC7
    CALL PRINT.TIME
    
    
    MOVLW 0X17 ;-------->SET.HOURS
    MOVWF 0X54
    CALL BCD.2.DIG
    MOVLW 0XC4
    CALL PRINT.TIME
    
    movlw 0x3b
    movwf 0x55
    
    movlw 0x17
    movwf 0x56
    
    
    
TIME.SEC:
    
    bcf STATUS,Z
    call DELAY.1SEC.TMR1  ;delay
    
    movfw 0x55            ;constent=59
    subwf 0x52,w
    
    btfsc STATUS,Z    
    goto TIME.MIN ;1
    incf 0x52      ;0

    MOVFW 0X52
    CALL BCD.2.DIG
    MOVLW 0XCA
    CALL PRINT.TIME
                                
    goto TIME.SEC
    
    
TIME.MIN:
    
    clrf 0x52
    MOVFW 0X52
    CALL BCD.2.DIG
    MOVLW 0XCA
    CALL PRINT.TIME
    
    bcf STATUS,Z
    
    movfw 0x55            ;constent=59
    subwf 0x53,w

    btfsc STATUS,Z    
    goto TIME.HOUR ;1
    incf 0x53      ;0

    MOVFW 0X53
    CALL BCD.2.DIG
    MOVLW 0XC7
    CALL PRINT.TIME
    
GOTO TIME.SEC 
    
TIME.HOUR:
    
    CLRF 0X53
    MOVFW 0X53
    CALL BCD.2.DIG
    MOVLW 0XC7
    CALL PRINT.TIME
    
    
    bcf STATUS,Z
    
    movfw 0x56            ;constent=23
    subwf 0x54,w

    btfsc STATUS,Z    
    goto RESET.HOUR;1
    incf 0x54      ;0

    MOVFW 0X54
    CALL BCD.2.DIG
    MOVLW 0XC4
    CALL PRINT.TIME
    
    goto TIME.SEC     
    
    RESET.HOUR:
    
    CLRF 0X54
    MOVFW 0X54
    CALL BCD.2.DIG
    MOVLW 0XC4
    CALL PRINT.TIME
    
    GOTO TIME.SEC
    
    DELAY.1SEC.TMR1:
    MOVLW 0X31             ;PRE,CLOCK CHOOSE,ENEBALE BIT
    MOVWF T1CON
    MOVLW 0XC8             ;LOW
    MOVWF TMR1L
    MOVLW 0X32
    MOVWF TMR1H            ;HIGH
    BSF PIE1,TMR1IE        ;INTURPPET ENABLER? YES
    BCF PIR1,TMR1IF        ;INIT INTURPET

    MOVLW 0X04
    MOVWF 0X45
    
LOOP.1KHZ:
    BTFSS PIR1,TMR1IF
    GOTO LOOP.1KHZ
    
INTURREPT:
    BCF PIR1,TMR1IF
    DECFSZ 0x45,F
    GOTO LOOP.1KHZ
    RETURN


END