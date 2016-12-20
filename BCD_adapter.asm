 LIST   	P=PIC16F877
#include <P16f877.inc>
    
BCDI CODE 0X60  
BCD.3:                         ;Timer=0x41                                
                             ;d1=0x50
Init.Func.BCD.3:               ;d2=0x51
                             ;d3=0x52
    MOVLW 0x0A               ;BCD={d3,d2,d1}
    MOVWF 0x40
    
    MOVFW 0x49
    MOVWF 0x41
    
    MOVLW 0x03
    MOVWF 0x48

    MOVLW 0x50
    MOVWF FSR

DigitLoop.3:
    
    CALL Hiluk
    
    MOVFW 0x43
    MOVWF INDF
    
    INCF FSR
    
    MOVFW 0X42
    MOVWF 0X41
    
    DECFSZ 0X48,F
    GOTO DigitLoop.3
   
    RETURN
 GLOBAL BCD.3

 
BCD.2:
                        ;Timer=0x41                                
                             ;d1=0x50
Init.Func.BCD.2:               ;d2=0x51
                             ;d3=0x52
    MOVLW 0x0A               ;BCD={d3,d2,d1}
    MOVWF 0x40
    
    MOVFW 0x49
    MOVWF 0x41
    
    MOVLW 0x02
    MOVWF 0x48

    MOVLW 0x50
    MOVWF FSR

DigitLoop.2:
    
    CALL Hiluk
    
    MOVFW 0x43
    MOVWF INDF
    
    INCF FSR
    
    MOVFW 0X42
    MOVWF 0X41
    
    DECFSZ 0X48,F
    GOTO DigitLoop.2
   
    RETURN   
 
Hiluk:                    ;R=0X43 ,Q=0X42
    
PreCheckH:
    
    MOVLW 0X00
    
    bcf STATUS,2
    
    iorwf 0x41,W
    btfsc STATUS,2
    goto ZeroDivWithNum
    
    MOVLW 0X00
    
    iorwf 0x40,W
    btfsc STATUS,2
    goto CantDivByZero

BuilderH:
    
    clrf 0x43
    bcf STATUS,2
    
    movfw 0x41
    movwf 0x42
    
    clrw 
    MOVLW 0x08
    movwf 0x41
    
LoopHiluk:
    
    bcf STATUS,0
    rlf 0x42,1
    rlf 0x43,1
    
    movfw 0x40
    subwf 0x43,0
    
    btfss STATUS,0
    goto MbigerBNo    
    goto MbigerBYes
    
MbigerBYes:
    movwf 0x43
    bsf 0x42,0
    
MbigerBNo:
    decfsz 0x41,F
    goto LoopHiluk

    RETURN           ;END OF HILUK 

ZeroDivWithNum:
 clrf 0x43
 clrf 0x42   
    
    RETURN           ;END HILUK Q=0X42=0,R=0X43=0
    
CantDivByZero:       ;Print on Lcd Err:"DivBy0"
                     ;will never be used 
		     ;--->0x40=10(constent)

		     

    END