
_clignoter:

;MyProject.c,31 :: 		void clignoter() { //2fois
;MyProject.c,32 :: 		for (i = 0; i < 2; i++) {
	CLRF       _i+0
L_clignoter0:
	MOVLW      2
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_clignoter1
;MyProject.c,33 :: 		portb.rb1 = 1;
	BSF        PORTB+0, 1
;MyProject.c,34 :: 		portb.rb2 = 1;
	BSF        PORTB+0, 2
;MyProject.c,35 :: 		delay_ms(500);
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
;MyProject.c,36 :: 		portb.rb1 = 0;
	BCF        PORTB+0, 1
;MyProject.c,37 :: 		delay_ms(500);
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
;MyProject.c,32 :: 		for (i = 0; i < 2; i++) {
	INCF       _i+0, 1
;MyProject.c,38 :: 		}
	GOTO       L_clignoter0
L_clignoter1:
;MyProject.c,39 :: 		portb.rb2 = 0;
	BCF        PORTB+0, 2
;MyProject.c,40 :: 		}
L_end_clignoter:
	RETURN
; end of _clignoter

_afficherMD:

;MyProject.c,41 :: 		void afficherMD() {
;MyProject.c,42 :: 		portc.rc0 = 1; // allumer speaker
	BSF        PORTC+0, 0
;MyProject.c,43 :: 		Lcd_Out(1, 1, array);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _array+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,44 :: 		Lcd_Out(2, 1, array2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _array2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,45 :: 		}
L_end_afficherMD:
	RETURN
; end of _afficherMD

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,46 :: 		void interrupt() {
;MyProject.c,47 :: 		if (intcon.INTF) {
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt5
;MyProject.c,48 :: 		porta.ra1 = 0;
	BCF        PORTA+0, 1
;MyProject.c,49 :: 		clignoter();
	CALL       _clignoter+0
;MyProject.c,50 :: 		}
L_interrupt5:
;MyProject.c,51 :: 		intcon.INTF = 0; //flag=0
	BCF        INTCON+0, 1
;MyProject.c,53 :: 		if (intcon.rbif) {
	BTFSS      INTCON+0, 0
	GOTO       L_interrupt6
;MyProject.c,54 :: 		if (portb.rb5 == 1) {
	BTFSS      PORTB+0, 5
	GOTO       L_interrupt7
;MyProject.c,55 :: 		portb.rb6 = 1;
	BSF        PORTB+0, 6
;MyProject.c,56 :: 		portb.rb7 = 0;
	BCF        PORTB+0, 7
;MyProject.c,57 :: 		delay_ms(1000);
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
;MyProject.c,58 :: 		} else {
	GOTO       L_interrupt9
L_interrupt7:
;MyProject.c,59 :: 		portb.rb6 = 0;
	BCF        PORTB+0, 6
;MyProject.c,60 :: 		portb.rb7 = 0;
	BCF        PORTB+0, 7
;MyProject.c,61 :: 		delay_ms(100);
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
;MyProject.c,62 :: 		}
L_interrupt9:
;MyProject.c,63 :: 		if (portb.rb4 == 1) {
	BTFSS      PORTB+0, 4
	GOTO       L_interrupt11
;MyProject.c,64 :: 		portb.rb6 = 0;
	BCF        PORTB+0, 6
;MyProject.c,65 :: 		portb.rb7 = 1;
	BSF        PORTB+0, 7
;MyProject.c,66 :: 		delay_ms(1000);
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
;MyProject.c,67 :: 		} else {
	GOTO       L_interrupt13
L_interrupt11:
;MyProject.c,68 :: 		portb.rb6 = 0;
	BCF        PORTB+0, 6
;MyProject.c,69 :: 		portb.rb7 = 0;
	BCF        PORTB+0, 7
;MyProject.c,70 :: 		delay_ms(100);
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
;MyProject.c,71 :: 		}
L_interrupt13:
;MyProject.c,73 :: 		}
L_interrupt6:
;MyProject.c,74 :: 		intcon.rbif = 0; //flag=0
	BCF        INTCON+0, 0
;MyProject.c,75 :: 		if (intcon.T0IF) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt15
;MyProject.c,76 :: 		NB--;
	MOVLW      1
	SUBWF      _NB+0, 1
	BTFSS      STATUS+0, 0
	DECF       _NB+1, 1
;MyProject.c,77 :: 		if (NB == 0) { // le temps (8s) est passé
	MOVLW      0
	XORWF      _NB+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt59
	MOVLW      0
	XORWF      _NB+0, 0
L__interrupt59:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt16
;MyProject.c,78 :: 		flagT = 1;
	MOVLW      1
	MOVWF      _flagT+0
;MyProject.c,79 :: 		NB = 31; // Initialsier NB
	MOVLW      31
	MOVWF      _NB+0
	MOVLW      0
	MOVWF      _NB+1
;MyProject.c,80 :: 		TMR0 = 0; // Initialiser timer
	CLRF       TMR0+0
;MyProject.c,81 :: 		}
L_interrupt16:
;MyProject.c,82 :: 		}
L_interrupt15:
;MyProject.c,83 :: 		intcon.T0IF = 0; // flag = 0
	BCF        INTCON+0, 2
;MyProject.c,84 :: 		}
L_end_interrupt:
L__interrupt58:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;MyProject.c,85 :: 		void main() {
;MyProject.c,86 :: 		Degree[0] = 223;
	MOVLW      223
	MOVWF      _degree+0
;MyProject.c,87 :: 		ADCON1 = 0x04;
	MOVLW      4
	MOVWF      ADCON1+0
;MyProject.c,88 :: 		Lcd_Init(); // Initialize LCD
	CALL       _Lcd_Init+0
;MyProject.c,89 :: 		Lcd_Cmd(_LCD_CLEAR); // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,90 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,92 :: 		intcon.GIE = 1; //global inetrrupt
	BSF        INTCON+0, 7
;MyProject.c,93 :: 		intcon.inte = 1; //activer interruption sur rp0
	BSF        INTCON+0, 4
;MyProject.c,94 :: 		intcon.rbie = 1; //acriver interruption sur le portb
	BSF        INTCON+0, 3
;MyProject.c,95 :: 		intcon.T0IE = 1; // activer le timer
	BSF        INTCON+0, 5
;MyProject.c,96 :: 		TMR0 = 0; //initialiser timer
	CLRF       TMR0+0
;MyProject.c,97 :: 		option_reg = 0b00000111;
	MOVLW      7
	MOVWF      OPTION_REG+0
;MyProject.c,98 :: 		NB = 31; //initialiser le NB
	MOVLW      31
	MOVWF      _NB+0
	MOVLW      0
	MOVWF      _NB+1
;MyProject.c,99 :: 		option_reg.intedg = 1; //activer l'interruption sur front montant
	BSF        OPTION_REG+0, 6
;MyProject.c,101 :: 		trisb = 0b00111001;
	MOVLW      57
	MOVWF      TRISB+0
;MyProject.c,102 :: 		trisc = 0b00000000;
	CLRF       TRISC+0
;MyProject.c,103 :: 		trisc = 0;
	CLRF       TRISC+0
;MyProject.c,105 :: 		portb.rb1 = 0;
	BCF        PORTB+0, 1
;MyProject.c,106 :: 		portb.rb2 = 0;
	BCF        PORTB+0, 2
;MyProject.c,107 :: 		portb.rb6 = 0;
	BCF        PORTB+0, 6
;MyProject.c,108 :: 		portb.rb7 = 0;
	BCF        PORTB+0, 7
;MyProject.c,109 :: 		portc = 0;
	CLRF       PORTC+0
;MyProject.c,110 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,111 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
	NOP
	NOP
;MyProject.c,112 :: 		Lcd_Out(1, 1, txt1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,113 :: 		delay_ms(100); // Write text in first row
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	NOP
	NOP
;MyProject.c,114 :: 		Lcd_Out(2, 1, txt3); // Write text in second row
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,115 :: 		delay_ms(300);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      134
	MOVWF      R12+0
	MOVLW      153
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	DECFSZ     R11+0, 1
	GOTO       L_main19
;MyProject.c,116 :: 		for (j = 0; j < 32; j++) {
	CLRF       _j+0
L_main20:
	MOVLW      32
	SUBWF      _j+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main21
;MyProject.c,117 :: 		EEPROM_Write(0x10 + j, MD[j]);
	MOVF       _j+0, 0
	ADDLW      16
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _j+0, 0
	ADDLW      _MD+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;MyProject.c,118 :: 		delay_ms(20);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main23:
	DECFSZ     R13+0, 1
	GOTO       L_main23
	DECFSZ     R12+0, 1
	GOTO       L_main23
	NOP
;MyProject.c,116 :: 		for (j = 0; j < 32; j++) {
	INCF       _j+0, 1
;MyProject.c,119 :: 		}
	GOTO       L_main20
L_main21:
;MyProject.c,120 :: 		for (j = 0; j < 16; j++) {
	CLRF       _j+0
L_main24:
	MOVLW      16
	SUBWF      _j+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main25
;MyProject.c,121 :: 		array[j] = EEPROM_Read(0x10 + j);
	MOVF       _j+0, 0
	ADDLW      _array+0
	MOVWF      FLOC__main+0
	MOVF       _j+0, 0
	ADDLW      16
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;MyProject.c,122 :: 		delay_ms(20);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main27:
	DECFSZ     R13+0, 1
	GOTO       L_main27
	DECFSZ     R12+0, 1
	GOTO       L_main27
	NOP
;MyProject.c,120 :: 		for (j = 0; j < 16; j++) {
	INCF       _j+0, 1
;MyProject.c,123 :: 		}
	GOTO       L_main24
L_main25:
;MyProject.c,124 :: 		for (j = 0; j < 16; j++) {
	CLRF       _j+0
L_main28:
	MOVLW      16
	SUBWF      _j+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main29
;MyProject.c,125 :: 		array2[j] = EEPROM_Read(0x20 + j);
	MOVF       _j+0, 0
	ADDLW      _array2+0
	MOVWF      FLOC__main+0
	MOVF       _j+0, 0
	ADDLW      32
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;MyProject.c,126 :: 		delay_ms(20);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main31:
	DECFSZ     R13+0, 1
	GOTO       L_main31
	DECFSZ     R12+0, 1
	GOTO       L_main31
	NOP
;MyProject.c,124 :: 		for (j = 0; j < 16; j++) {
	INCF       _j+0, 1
;MyProject.c,127 :: 		}
	GOTO       L_main28
L_main29:
;MyProject.c,128 :: 		while (1) {
L_main32:
;MyProject.c,129 :: 		if (flagT == 1) {
	MOVF       _flagT+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main34
;MyProject.c,130 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,131 :: 		afficherMD(); // afficher les médicaments
	CALL       _afficherMD+0
;MyProject.c,132 :: 		delay_ms(600);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	DECFSZ     R11+0, 1
	GOTO       L_main35
	NOP
	NOP
;MyProject.c,133 :: 		Temp = ADC_Read(0) * 0.489; // Read analog voltage and convert it to degree Celsius (0.489 = 500/1023)
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVLW      53
	MOVWF      R4+0
	MOVLW      94
	MOVWF      R4+1
	MOVLW      122
	MOVWF      R4+2
	MOVLW      125
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2word+0
	MOVF       R0+0, 0
	MOVWF      _Temp+0
	MOVF       R0+1, 0
	MOVWF      _Temp+1
;MyProject.c,134 :: 		portc.rc0 = 0; // déallumer speaker
	BCF        PORTC+0, 0
;MyProject.c,135 :: 		Lcd_Cmd(_LCD_CLEAR); // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,136 :: 		flagT = 0;
	CLRF       _flagT+0
;MyProject.c,137 :: 		resume = 1;
	MOVLW      1
	MOVWF      _resume+0
;MyProject.c,138 :: 		}
L_main34:
;MyProject.c,139 :: 		if (temp > 99)
	MOVF       _Temp+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVF       _Temp+0, 0
	SUBLW      99
L__main61:
	BTFSC      STATUS+0, 0
	GOTO       L_main36
;MyProject.c,140 :: 		Temperature[0] = 1 + 48; // Put 1 (of hundred)
	MOVLW      49
	MOVWF      _Temperature+0
	GOTO       L_main37
L_main36:
;MyProject.c,142 :: 		Temperature[0] = ' '; // Put space
	MOVLW      32
	MOVWF      _Temperature+0
L_main37:
;MyProject.c,143 :: 		Temperature[1] = (temp / 10) % 10 + 48;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Temp+0, 0
	MOVWF      R0+0
	MOVF       _Temp+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _Temperature+1
;MyProject.c,144 :: 		Temperature[2] = temp % 10 + 48;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Temp+0, 0
	MOVWF      R0+0
	MOVF       _Temp+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _Temperature+2
;MyProject.c,145 :: 		Temperature[5] = 223; // Put degree symbol ( ° )
	MOVLW      223
	MOVWF      _Temperature+5
;MyProject.c,146 :: 		Lcd_Cmd(_LCD_CLEAR); // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,147 :: 		lcd_out(1, 3, "Temperature:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,148 :: 		delay_ms(20);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_main38:
	DECFSZ     R13+0, 1
	GOTO       L_main38
	DECFSZ     R12+0, 1
	GOTO       L_main38
	NOP
;MyProject.c,149 :: 		lcd_out(2, 5, Temperature); // Display LM35 temperature result
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _Temperature+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,150 :: 		Delay_ms(600);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main39:
	DECFSZ     R13+0, 1
	GOTO       L_main39
	DECFSZ     R12+0, 1
	GOTO       L_main39
	DECFSZ     R11+0, 1
	GOTO       L_main39
	NOP
	NOP
;MyProject.c,151 :: 		if (Temp < 1) {
	MOVLW      0
	SUBWF      _Temp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVLW      1
	SUBWF      _Temp+0, 0
L__main62:
	BTFSC      STATUS+0, 0
	GOTO       L_main40
;MyProject.c,152 :: 		for (i = 0; i < 3; i++) {
	CLRF       _i+0
L_main41:
	MOVLW      3
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main42
;MyProject.c,153 :: 		portc.rc3 = 1;
	BSF        PORTC+0, 3
;MyProject.c,154 :: 		delay_ms(250);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main44:
	DECFSZ     R13+0, 1
	GOTO       L_main44
	DECFSZ     R12+0, 1
	GOTO       L_main44
	DECFSZ     R11+0, 1
	GOTO       L_main44
	NOP
	NOP
;MyProject.c,155 :: 		portc.rc3 = 0;
	BCF        PORTC+0, 3
;MyProject.c,156 :: 		delay_ms(250);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main45:
	DECFSZ     R13+0, 1
	GOTO       L_main45
	DECFSZ     R12+0, 1
	GOTO       L_main45
	DECFSZ     R11+0, 1
	GOTO       L_main45
	NOP
	NOP
;MyProject.c,152 :: 		for (i = 0; i < 3; i++) {
	INCF       _i+0, 1
;MyProject.c,157 :: 		}
	GOTO       L_main41
L_main42:
;MyProject.c,158 :: 		}
L_main40:
;MyProject.c,159 :: 		if (resume == 1) {
	MOVF       _resume+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main46
;MyProject.c,160 :: 		if (Temp > 39) {
	MOVF       _Temp+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVF       _Temp+0, 0
	SUBLW      39
L__main63:
	BTFSC      STATUS+0, 0
	GOTO       L_main47
;MyProject.c,161 :: 		portc.rc1 = 1;
	BSF        PORTC+0, 1
;MyProject.c,162 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main48:
	DECFSZ     R13+0, 1
	GOTO       L_main48
	DECFSZ     R12+0, 1
	GOTO       L_main48
	DECFSZ     R11+0, 1
	GOTO       L_main48
	NOP
	NOP
;MyProject.c,163 :: 		portc.rc1 = 0;
	BCF        PORTC+0, 1
;MyProject.c,164 :: 		resume = 0;
	CLRF       _resume+0
;MyProject.c,165 :: 		} else if ((Temp <= 39) && (Temp > 1)) {
	GOTO       L_main49
L_main47:
	MOVF       _Temp+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	MOVF       _Temp+0, 0
	SUBLW      39
L__main64:
	BTFSS      STATUS+0, 0
	GOTO       L_main52
	MOVF       _Temp+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main65
	MOVF       _Temp+0, 0
	SUBLW      1
L__main65:
	BTFSC      STATUS+0, 0
	GOTO       L_main52
L__main54:
;MyProject.c,166 :: 		portc.rc2 = 1;
	BSF        PORTC+0, 2
;MyProject.c,167 :: 		delay_ms(400);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main53:
	DECFSZ     R13+0, 1
	GOTO       L_main53
	DECFSZ     R12+0, 1
	GOTO       L_main53
	DECFSZ     R11+0, 1
	GOTO       L_main53
;MyProject.c,168 :: 		portc.rc2 = 0;
	BCF        PORTC+0, 2
;MyProject.c,169 :: 		resume = 0;
	CLRF       _resume+0
;MyProject.c,170 :: 		}
L_main52:
L_main49:
;MyProject.c,171 :: 		}
L_main46:
;MyProject.c,172 :: 		}
	GOTO       L_main32
;MyProject.c,173 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
