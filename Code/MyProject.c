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
int i;
char txt1[] = "YACINE";
char txt2[] = "KHOUINI";
int t;
char lcd[] = "000 Degree" ;
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
      }
      intcon.INTF=0;           //flag=0
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
      }
}
void main(){
 ADCON1=0x04;
  Lcd_Init();                        // Initialize LCD
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off

  //Lcd_Cmd(_LCD_CLEAR);               // Clear display
  //Configuration des interruptions
  intcon.GIE=1;   //global inetrrupt
  intcon.inte=1;  //inte=rb0
  intcon.rbie=1;
  option_reg.intedg=1;   //activer l'interruption sur front montant
  //Configuraton des E/S
  trisb=0b00111001;
  //Initialisation
  portb.rb1=0;
  portb.rb2=0;
  portb.rb6=0;
  portb.rb7=0;


  do{
    //Lcd_Out(1,1,txt1);                 // Write text in first row
    //Lcd_Out(2,1,txt2);               // Write text in second row

    Lcd_Cmd(_LCD_CLEAR);
    Lcd_out(1,1, "Temperature");

    
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
    
    Lcd_Out(2,1,lcd);
    Delay_ms(200);
    
  }while (1);
  
}