
; PIC16F877 Configuration Bit Settings

; Assembly source line config statements

#include "p16F877.inc"

; CONFIG
; __config 0xFFFB
 __CONFIG _FOSC_EXTRC & _WDTE_OFF & _PWRTE_OFF & _CP_OFF & _BOREN_ON & _LVP_ON & _CPD_OFF & _WRT_ON
    
    org 0x00
    
Reset:
    addlw 0x02
    movwf 0x40
    clrw
    addlw 0x09
    movwf 0x41
    
    goto Start

  
     Start:
     clrf 003h     
     bsf 003h,0x04 
     bsf 003h,0x03

main:
     ;goto Hisor
     ;goto Kafal
     ;goto boothKafal
    goto Hiluk
Hisor:
     movf 0x36,0x00
     subwf 0x35,0x00

     btfss 003h,0
     call Abs

     movwf 0x37
     goto exit


boothKafal:
    
PreCheckK:
    clrw
    clrf 0x43
    clrf 0x42

    bcf 003h,2
    
    iorwf 0x41,1
    iorwf 0x40,1

    btfsc 003h,2
    goto zerokapalexit ;1
                       ;0
BuilderK:
    
    clrw
    bcf 003h,2
    
    bcf 003h,0
    
    addlw 0x08
    movwf 0x38
  
    clrf 0x39
    btfsc 0x40,0
    bsf 0x39,1
    bcf 0x39,1
    
    movf 0x40,0
    movwf 0x42
    
    comf 0x41,0
    movwf 0x40
    incf 0x40
    
LoopBooth:
   
    btfsc 0x42,0
    goto nextIfZero ;1
    btfsc 003h,0    ;0
    goto  MplusA    ;0,1
    goto MtoBtoLast ;0,0
    
    nextIfZero:
    btfsc 003h,1
    goto MtoBtoLast ;1,1
    goto MpahutA    ;1,0
    
    MplusA:
    movfw 0x41
    addwf 0x43,1
    bcf 003h,0
    goto MtoBtoLast
    
    MpahutA:
    movfw 0x40
    addwf 0x43,1
    bsf 003h,0
    
    
    MtoBtoLast:
    
    rrf 0x43,1
    rrf 0x42,1
    
    
    decfsz 0x38,1
    goto LoopBooth
    goto exit

    

Hiluk:
    
PreCheckH:
    clrw
    
    bcf 003h,2
    
    iorwf 0x41,1
    btfsc 003h,2
    goto zerokapalexit
    
    iorwf 0x40,1
    btfsc 003h,2
    goto CantDivByZero

    BuilderH:
    
    clrf 0x43
    bcf 003h,2
    
    movfw 0x41
    movwf 0x42
    
    clrw 
    addlw 0x08
    movwf 0x41
    
    LoopHiluk:
    
    bcf 003h,0
    rlf 0x42,1
    rlf 0x43,1
    
    movfw 0x40
    subwf 0x43,0
    
    btfss 003h,0
    goto MbigerBNo    
    goto MbigerBYes
    
    MbigerBYes:
    movwf 0x43
    bsf 0x42,0
    
    MbigerBNo:
    decfsz 0x41,1
    goto LoopHiluk

    goto exit
    

   Abs:
   comf  0x37,1
   incf 0x37,0
   return

  


zerokapalexit:
clrf 0x43
clrf 0x42    

CantDivByZero:

exit: 
       END








  
