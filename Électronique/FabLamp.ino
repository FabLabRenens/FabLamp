/*
########  FabLamp  ########
FabLab Chêne20 (Renens CH)
https://github.com/FabLabChene20/FabLamp
Arduino IDE v1.6.6
*/

#define LEDR 0 // PWM 0  Pin physique 5
#define LEDB 1 // PWM 1  Pin physique 6
#define LEDG 4 // PWM 2  Pin physique 3
#define POT 3  // Input  Pin Physique 2

int val = 0 ;

void setup() {
  pinMode(LEDR,OUTPUT);
  pinMode(LEDG,OUTPUT);
  pinMode(LEDB,OUTPUT);
  pinMode(POT,INPUT);  
}

void loop() {     
     val = analogRead(POT);

     //Séquence RGB
     if (val < 25) {
      analogWrite(LEDR,200);
      analogWrite(LEDG,0);
      analogWrite(LEDB,0);     
      delay(600);
      analogWrite(LEDR,0);
      analogWrite(LEDG,200);
      analogWrite(LEDB,0);
      delay(600);
      analogWrite(LEDR,0);
      analogWrite(LEDG,0);
      analogWrite(LEDB,200);
      delay(600);
     } else { //Gradation lumière blanche
      analogWrite(LEDR,map(val,26,1024,0,100));
      analogWrite(LEDG,map(val,26,1024,0,255));
      analogWrite(LEDB,map(val,26,1024,0,255));
     }
     delay(60);
}


