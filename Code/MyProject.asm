
_clignoter:

;MyProject.c,23 :: 		void clignoter(){                                //2fois
;MyProject.c,24 :: 		for(i=0;i<2;i++){
	CLRF       _i+0
	CLRF       _i+1
L_clignoter0:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__clignoter20
	MOVLW      2
	SUBWF      _i+0, 0
L__clignoter20:
	BTFSC      STATUS+0, 0
	GOTO       L_clignoter1
;MyProject.c,25 :: 		portb.rb1=1 ;
	BSF        PORTB+0, 1
;MyProject.c,26 :: 		portb.rb2=1 ;
	BSF        PORTB+0, 2
;MyProject.c,27 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_clignoter3:
	DECFSZ     R13+0, 1
	GOTO       L_clignoter3
	DECFSZ     R12+0, 1
	GOTO       L_clignoter3
	DECFSZ     R11+0, 1
	GOTO       L_clignoter3
	NOP
	NOP
;MyProject.c,28 :: 		portb.rb1=0 ;
	BCF        PORTB+0, 1
;MyProject.c,29 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_clignoter4:
	DECFSZ     R13+0, 1
	GOTO       L_clignoter4
	DECFSZ     R12+0, 1
	GOTO       L_clignoter4
	DECFSZ     R11+0, 1
	GOTO       L_clignoter4
	NOP
	NOP
;MyProject.c,24 :: 		for(i=0;i<2;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MyProject.c,30 :: 		}
	GOTO       L_clignoter0
L_clignoter1:
;MyProject.c,31 :: 		portb.rb2=0 ;
	BCF        PORTB+0, 2
;MyProject.c,33 :: 		}
L_end_clignoter:
	RETURN
; end of _clignoter

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,34 :: 		void interrupt(){
;MyProject.c,35 :: 		if(intcon.INTF) {
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt5
;MyProject.c,36 :: 		porta.ra1=0;
	BCF        PORTA+0, 1
;MyProject.c,37 :: 		clignoter();
	CALL       _clignoter+0
;MyProject.c,38 :: 		}
L_interrupt5:
;MyProject.c,39 :: 		intcon.INTF=0;           //flag=0
	BCF        INTCON+0, 1
;MyProject.c,40 :: 		if(intcon.rbif) {
	BTFSS      INTCON+0, 0
	GOTO       L_interrupt6
;MyProject.c,41 :: 		if (portb.rb5==1){
	BTFSS      PORTB+0, 5
	GOTO       L_interrupt7
;MyProject.c,42 :: 		portb.rb6=1;
	BSF        PORTB+0, 6
;MyProject.c,43 :: 		portb.rb7=0;
	BCF        PORTB+0, 7
;MyProject.c,44 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_interrupt8:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt8
	DECFSZ     R12+0, 1
	GOTO       L_interrupt8
	DECFSZ     R11+0, 1
	GOTO       L_interrupt8
	NOP
	NOP
;MyProject.c,45 :: 		}else{
	GOTO       L_interrupt9
L_interrupt7:
;MyProject.c,46 :: 		portb.rb6=0;
	BCF        PORTB+0, 6
;MyProject.c,47 :: 		portb.rb7=0;
	BCF        PORTB+0, 7
;MyProject.c,48 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_interrupt10:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt10
	DECFSZ     R12+0, 1
	GOTO       L_interrupt10
	NOP
	NOP
;MyProject.c,49 :: 		}
L_interrupt9:
;MyProject.c,50 :: 		if (portb.rb4==1){
	BTFSS      PORTB+0, 4
	GOTO       L_interrupt11
;MyProject.c,51 :: 		portb.rb6=0;
	BCF        PORTB+0, 6
;MyProject.c,52 :: 		portb.rb7=1;
	BSF        PORTB+0, 7
;MyProject.c,53 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_interrupt12:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt12
	DECFSZ     R12+0, 1
	GOTO       L_interrupt12
	DECFSZ     R11+0, 1
	GOTO       L_interrupt12
	NOP
	NOP
;MyProject.c,54 :: 		}else{
	GOTO       L_interrupt13
L_interrupt11:
;MyProject.c,55 :: 		portb.rb6=0;
	BCF        PORTB+0, 6
;MyProject.c,56 :: 		portb.rb7=0;
	BCF        PORTB+0, 7
;MyProject.c,57 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_interrupt14:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt14
	DECFSZ     R12+0, 1
	GOTO       L_interrupt14
	NOP
	NOP
;MyProject.c,58 :: 		}
L_interrupt13:
;MyProject.c,59 :: 		}
L_interrupt6:
;MyProject.c,60 :: 		}
L_end_interrupt:
L__interrupt22:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;MyProject.c,61 :: 		void main(){
;MyProject.c,62 :: 		ADCON1=0x04;
	MOVLW      4
	MOVWF      ADCON1+0
;MyProject.c,63 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;MyProject.c,64 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,68 :: 		intcon.GIE=1;   //global inetrrupt
	BSF        INTCON+0, 7
;MyProject.c,69 :: 		intcon.inte=1;  //inte=rb0
	BSF        INTCON+0, 4
;MyProject.c,70 :: 		intcon.rbie=1;
	BSF        INTCON+0, 3
;MyProject.c,71 :: 		option_reg.intedg=1;   //activer l'interruption sur front montant
	BSF        OPTION_REG+0, 6
;MyProject.c,73 :: 		trisb=0b00111001;
	MOVLW      57
	MOVWF      TRISB+0
;MyProject.c,75 :: 		portb.rb1=0;
	BCF        PORTB+0, 1
;MyProject.c,76 :: 		portb.rb2=0;
	BCF        PORTB+0, 2
;MyProject.c,77 :: 		portb.rb6=0;
	BCF        PORTB+0, 6
;MyProject.c,78 :: 		portb.rb7=0;
	BCF        PORTB+0, 7
;MyProject.c,81 :: 		do{
L_main15:
;MyProject.c,85 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,86 :: 		Lcd_out(1,1, "Temperature");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,89 :: 		t = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _t+0
	MOVF       R0+1, 0
	MOVWF      _t+1
;MyProject.c,90 :: 		t=t*0.4887;
	CALL       _int2double+0
	MOVLW      227
	MOVWF      R4+0
	MOVLW      54
	MOVWF      R4+1
	MOVLW      122
	MOVWF      R4+2
	MOVLW      125
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVF       FLOC__main+0, 0
	MOVWF      _t+0
	MOVF       FLOC__main+1, 0
	MOVWF      _t+1
;MyProject.c,91 :: 		temperature = t%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _temperature+0
;MyProject.c,92 :: 		lcd[2] = temperature + '0';
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _lcd+2
;MyProject.c,94 :: 		t=t/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVF       FLOC__main+0, 0
	MOVWF      _t+0
	MOVF       FLOC__main+1, 0
	MOVWF      _t+1
;MyProject.c,95 :: 		temperature=t%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _temperature+0
;MyProject.c,96 :: 		lcd[1] = temperature + '0';
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _lcd+1
;MyProject.c,98 :: 		t=t/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _t+0
	MOVF       R0+1, 0
	MOVWF      _t+1
;MyProject.c,99 :: 		temperature=t%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _temperature+0
;MyProject.c,100 :: 		lcd[0] = temperature + '0';
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _lcd+0
;MyProject.c,102 :: 		Lcd_Out(2,1,lcd);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcd+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,103 :: 		Delay_ms(200);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	DECFSZ     R11+0, 1
	GOTO       L_main18
	NOP
;MyProject.c,105 :: 		}while (1);
	GOTO       L_main15
;MyProject.c,107 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
