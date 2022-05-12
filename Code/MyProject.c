// LCD module connections
//Association des broches LCD au port b du pic
sbit LCD_RS at RD4_bit;
sbit LCD_EN at RD5_bit;
sbit LCD_D4 at RD0_bit;
sbit LCD_D5 at RD1_bit;
sbit LCD_D6 at RD2_bit;
sbit LCD_D7 at RD3_bit;
//D?finition du sens
sbit LCD_RS_Direction at TRISD4_bit;
sbit LCD_EN_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD0_bit;
sbit LCD_D5_Direction at TRISD1_bit;
sbit LCD_D6_Direction at TRISD2_bit;
sbit LCD_D7_Direction at TRISD3_bit;
// End LCD module connections
char resume = 0;
char flagT = 0;
char j;
char array[] = "";
char array2[] = "";
char MD[] = "Ebixa 10mg 2/J  Aricept 10mg 3/J";
char i;
char b;
int NB;
char txt1[] = "Nom Patient     ";
char Temperature[] = " 00.0 C";
char degree[] = " ";
unsigned int Temp;
char txt3[] = "Have a good time";
int t;
void clignoter() { //2fois
  for (i = 0; i < 2; i++) {
    portb.rb1 = 1;
    portb.rb2 = 1;
    delay_ms(500);
    portb.rb1 = 0;
    delay_ms(500);
  }
  portb.rb2 = 0;
}
void afficherMD() {
  portc.rc0 = 1; // allumer speaker
  Lcd_Out(1, 1, array);
  Lcd_Out(2, 1, array2);
}
void interrupt() {
  if (intcon.INTF) {
    porta.ra1 = 0;
    clignoter();
    intcon.INTF = 0; //flag=0
  }
  if (intcon.rbif) {
    if (portb.rb5 == 1) {
      portb.rb6 = 1;
      portb.rb7 = 0;
      delay_ms(1000);
    } else {
      portb.rb6 = 0;
      portb.rb7 = 0;
      delay_ms(100);
    }
    if (portb.rb4 == 1) {
      portb.rb6 = 0;
      portb.rb7 = 1;
      delay_ms(1000);
    } else {
      portb.rb6 = 0;
      portb.rb7 = 0;
      delay_ms(100);
    }
    intcon.rbif = 0; //flag=0
  }

  if (intcon.T0IF) {
    NB--;
    if (NB == 0) { // le temps (8s) est pass?
      flagT = 1;
      NB = 31; // Initialsier NB
      TMR0 = 0; // Initialiser timer
    }
  }
  intcon.T0IF = 0; // flag = 0

}
void main() {
  Degree[0] = 223;
  ADCON1 = 0x04;
  Lcd_Init(); // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR); // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off
  //Configuration des interruptions
  intcon.GIE = 1; //global inetrrupt
  intcon.inte = 1; //activer interruption sur rp0
  intcon.rbie = 1; //acriver interruption sur le portb
  intcon.T0IE = 1; // activer le timer
  TMR0 = 0; //initialiser timer
  option_reg = 0b00000111;
  NB = 31; //initialiser le NB
  option_reg.intedg = 1; //activer l'interruption sur front montant
  //Configuraton des E/S
  trisb = 0b00111001;
  trisc = 0b00000000;
  trisc = 0;
  //Initialisation
  portb.rb1 = 0;
  portb.rb2 = 0;
  portb.rb6 = 0;
  portb.rb7 = 0;
  portc = 0;
  Lcd_Cmd(_LCD_CLEAR);
  delay_ms(100);
  Lcd_Out(1, 1, txt1);
  delay_ms(100); // Write text in first row
  Lcd_Out(2, 1, txt3); // Write text in second row
  delay_ms(300);
  for (j = 0; j < 32; j++) {
    EEPROM_Write(0x10 + j, MD[j]);
    delay_ms(20);
  }
  for (j = 0; j < 16; j++) {
    array[j] = EEPROM_Read(0x10 + j);
    delay_ms(20);
  }
  for (b = 0; b < 16; b++) {
    array2[b] = EEPROM_Read(0x20 + b);
    delay_ms(20);
  }
  while (1) {
    if (flagT == 1) {
      Lcd_Cmd(_LCD_CLEAR);
      afficherMD(); // afficher les m?dicaments
      delay_ms(600);
      Temp = ADC_Read(0) * 0.489; // Read analog voltage and convert it to degree Celsius (0.489 = 500/1023)
      portc.rc0 = 0; // d?allumer speaker
      Lcd_Cmd(_LCD_CLEAR); // Clear display
      flagT = 0;
      resume = 1;
    }
    if (temp > 99)
      Temperature[0] = 1 + 48; // Put 1 (of hundred)
    else
      Temperature[0] = ' '; // Put space
    Temperature[1] = (temp / 10) % 10 + 48;
    Temperature[2] = temp % 10 + 48;
    Temperature[5] = 223; // Put degree symbol ( ? )
    Lcd_Cmd(_LCD_CLEAR); // Clear display
    lcd_out(1, 3, "Temperature:");
    delay_ms(20);
    lcd_out(2, 5, Temperature); // Display LM35 temperature result
    Delay_ms(600);
    if (Temp < 1) {
      for (i = 0; i < 3; i++) {
        portc.rc3 = 1;
        delay_ms(250);
        portc.rc3 = 0;
        delay_ms(250);
      }
    }
    if (resume == 1) {
      if (Temp > 39) {
        portc.rc1 = 1;
        delay_ms(500);
        portc.rc1 = 0;
        resume = 0;
      } else if ((Temp <= 39) && (Temp > 1)) {
        portc.rc2 = 1;
        delay_ms(400);
        portc.rc2 = 0;
        resume = 0;
      }
    }
  }
}