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
char j;
char array[] = "";
char MD[] =  "Ebixa 10mg 2/J  Aricept 10mg 3/J";
char i;
int NB;
char txt1[] = "Worked          ";
char txt2[] = "Temperature       ";
char txt3[] = "successfully    ";
int t;
char lcd[] = "000 Degree      " ;
char temperature;
void clignoter(){                                //2fois
     for(i=0;i<2;i++){
        portb.rb1=1 ;
        portb.rb2=1 ;
        delay_ms(500);
        portb.rb1=0 ;
        delay_ms(500);
      }
      portb.rb2=0 ;

}
void interrupt(){
      if(intcon.INTF) {
        porta.ra1=0;
        clignoter();
                         //flag=0
      }            intcon.INTF=0;

      if(intcon.rbif) {
      if (portb.rb5==1){
             portb.rb6=1;
             portb.rb7=0;
             delay_ms(1000);
      }else{
             portb.rb6=0;
             portb.rb7=0;
             delay_ms(100);
      }
      if (portb.rb4==1){
             portb.rb6=0;
             portb.rb7=1;
             delay_ms(1000);
      }else{
             portb.rb6=0;
             portb.rb7=0;
             delay_ms(100);
      }
                //flag=0
      }intcon.rbif=0;
      if (intcon.T0IF){
         NB--;
         if (NB==0){
            //portc.rc0 =~ portc.rc0;
            portc.rc0=~portc.rc0;
            /*portc.rc0 = 1;
            delay_ms(400);
            portc.rc0 = 0;*/
            NB=30;
            TMR0=0;
         }

         intcon.T0IF=0;
      }


}
void main(){
 ADCON1=0x04;
  Lcd_Init();                        // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  //Configuration des interruptions
  intcon.GIE=1;   //global inetrrupt
  intcon.inte=1;  //inte=rb0
  intcon.rbie=1;
  intcon.T0IE=1;
  TMR0=0;
  option_reg = 0b00000111;
  NB=30;
  option_reg.intedg=1;   //activer l'interruption sur front montant
  //Configuraton des E/S
  trisb=0b00111001;
  trisc=0b00000000;
  trisc = 0;
  //Initialisation
  portb.rb1=0;
  portb.rb2=0;
  portb.rb6=0;
  portb.rb7=0;
  portc = 0;
      Lcd_Cmd(_LCD_CLEAR);
    delay_ms(100);
    Lcd_Out(1,1,txt1);
    delay_ms(100);                 // Write text in first row
    Lcd_Out(2,1,txt3);               // Write text in second row
    delay_ms(1000);

  for(j = 0; j < 32; j++){
        EEPROM_Write(0x10+j, MD[j]);
        delay_ms(20);
 }

  while(1){
    t = ADC_Read(0);
    t=t*0.4887;
    temperature = t%10;
    lcd[2] = temperature + '0';

    t=t/10;
    temperature=t%10;
    lcd[1] = temperature + '0';

    t=t/10;
    temperature=t%10;
    lcd[0] = temperature + '0';
    delay_ms(100);
    Lcd_Cmd(_LCD_CLEAR);                 // Clear display
    Lcd_out(1,1, txt2);
    delay_ms(20);
    Lcd_Out(2,1,lcd);
    Delay_ms(1000);
    for(j = 0; j < 16; j++){
        array[j] = EEPROM_Read(0x10+j);
        delay_ms(20);
    }
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Out(1,1,array);
    for(j = 0; j < 16; j++){
          array[j] = EEPROM_Read(0x20+j);
          delay_ms(20);
    }
    Lcd_Out(2,1,array);
    delay_ms(1000);

  }
}