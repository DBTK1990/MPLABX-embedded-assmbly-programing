
		LIST 	P=PIC16F877
		include	<P16f877.inc>
 __CONFIG _CP_OFF & _WDT_OFF & _BODEN_OFF & _PWRTE_OFF & _HS_OSC & _WRT_ENABLE_ON & _LVP_OFF & _DEBUG_ON & _CPD_OFF

		org 0x00
RESET:
    ;GOTO START1
    GOTO START2
    
    		org 0x10
		
START2:	
    CLRF 0X41
    clrf 0X42
    CLRF 0X40
    
    CALL BANK1
    CLRF TRISC
    
    CALL BANK0
    CLRF PORTC
    
    ACTION:
    CALL INITDELAY
    ;CALL delay_2.5KHZ
    BSF PORTC,RC2  
    CALL INITDELAY
    ;CALL delay_2.5KHZ              
    BCF PORTC,RC2    
       
    GOTO ACTION
		
    
		
START1:
   
    CALL BANK0
    CLRF PORTD
    CALL BANK1
    CLRF TRISD
    CALL BANK0
    MOVLW 0X0B
    MOVWF PORTD
    
 RLOOP:
    CALL INITDELAY
    RRF PORTD
 
    GOTO RLOOP
              
    
    
    
    INITDELAY:
    movlw 0X17
    movwf 0x40
    
    DELAY0:
    DECFSZ 0x40,f
    GOTO INITDELAY1
    RETURN
    
    INITDELAY1:
    movlw 0x1C
    movwf 0x41
    
    DELAY1:
    DECFSZ 0x41,f
    GOTO DELAY1
    GOTO DELAY0
    

    
    BANK0:
    BCF STATUS,RP0
    BCF STATUS,RP1
    RETURN
    
    BANK1:
    BCF STATUS,RP1
    BSF STATUS,RP0
    RETURN
   
      delay_2.5KHZ: 
      movlw 0xC8
      movwf 0x51   
      CONT1: 
      movlw 0x02  
      movwf 0x52   
      CONT2: 
      decfsz 0x52,F  
      goto  CONT2  
      decfsz 0x51,F   
      goto  CONT1  
 return 
    
END