#line 1 "D:/Documents/GitHub/Micro/Code/MyProject.c"


sbit LCD_RS at RD4_bit;
sbit LCD_EN at RD5_bit;
sbit LCD_D4 at RD0_bit;
sbit LCD_D5 at RD1_bit;
sbit LCD_D6 at RD2_bit;
sbit LCD_D7 at RD3_bit;

sbit LCD_RS_Direction at TRISD4_bit;
sbit LCD_EN_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD0_bit;
sbit LCD_D5_Direction at TRISD1_bit;
sbit LCD_D6_Direction at TRISD2_bit;
sbit LCD_D7_Direction at TRISD3_bit;

char resume = 0;
char flagT=0;
char j;
char array[] = "";
char MD[] = "Ebixa 10mg 2/J  Aricept 10mg 3/J";
char i;
int NB;
char txt1[] = "Worked          ";
char Temperature[] = " 00.0 C";
char degree[]= " " ;
unsigned int Temp;
char txt3[] = "successfully    ";
int t;
void clignoter(){
 for(i=0;i<2;i++){
 portb.rb1=1 ;
 portb.rb2=1 ;
 delay_ms(500);
 portb.rb1=0 ;
 delay_ms(500);
 }
 portb.rb2=0 ;
}
void afficherMD(){
 portc.rc0=1;
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
}
void interrupt(){
 if(intcon.INTF) {
 porta.ra1=0;
 clignoter();

 }intcon.INTF=0;

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

 }intcon.rbif=0;
 if (intcon.T0IF){
 NB--;
 if (NB==0){
 flagT=1;
 NB=30;
 TMR0=0;
 }
 }intcon.T0IF=0;
}

void main(){
Degree[0] = 223;
 ADCON1=0x04;
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 intcon.GIE=1;
 intcon.inte=1;
 intcon.rbie=1;
 intcon.T0IE=1;
 TMR0=0;
 option_reg = 0b00000111;
 NB=30;
 option_reg.intedg=1;

 trisb=0b00111001;
 trisc=0b00000000;
 trisc = 0;

 portb.rb1=0;
 portb.rb2=0;
 portb.rb6=0;
 portb.rb7=0;
 portc = 0;
 Lcd_Cmd(_LCD_CLEAR);
 delay_ms(100);
 Lcd_Out(1,1,txt1);
 delay_ms(100);
 Lcd_Out(2,1,txt3);
 delay_ms(300);
 for(j = 0; j < 32; j++){
 EEPROM_Write(0x10+j, MD[j]);
 delay_ms(20);
 }

 while(1){
 if (flagT == 1){

 afficherMD();
 Temp = ADC_Read(0) * 0.489;
 delay_ms(300);
 portc.rc0=0;
 Lcd_Cmd(_LCD_CLEAR);
 flagT=0;
 resume=1;
 }
if (temp > 99)
 Temperature[0] = 1 + 48;
 else
 Temperature[0] = ' ';
 Temperature[1] = (temp / 10) % 10 + 48;
 Temperature[2] = temp % 10 + 48;
 Temperature[5] = 223;
 Lcd_Cmd(_LCD_CLEAR);
 lcd_out(1, 3, "Temperature:");
 delay_ms(20);
 lcd_out(2, 5, Temperature);
 Delay_ms(20);
 if(Temp < 1){
 for(i=0;i<3;i++){
 portc.rc3 = 1;
 delay_ms(250);
 portc.rc3 = 0;
 delay_ms(250);
 }
 }
 if (resume == 1 ){
 if(Temp > 39){
 portc.rc1 = 1;
 delay_ms(400);
 portc.rc1 = 0;
 resume = 0;
 }else if((Temp <= 39)&&(Temp > 1)){
 portc.rc2 = 1;
 delay_ms(400);
 portc.rc2 = 0;
 resume = 0;
 }
 }


 }
}
