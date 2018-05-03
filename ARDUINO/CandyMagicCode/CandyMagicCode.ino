int sensorpin = 2;
int counter_val = 0;
int RPM = 0;
int lastDebounceTime = 0;
int debounceDelay = 5;
int tdiff = 0;
const int IN_A0 = A0;
int value_A0;
int now = 0;
int loopms = 1000;

void setup() {

 pinMode(sensorpin, INPUT_PULLUP);
 pinMode (IN_A0, INPUT);
 attachInterrupt(digitalPinToInterrupt(sensorpin), count, RISING);

 Serial.begin(115200);
 Serial.print("hello");
 lastDebounceTime = millis();

}

void loop() {

 delay(loopms);
 RPM = counter_val * (1000 / loopms) * 30;
//Serial.println(counter_val);
 counter_val=0;
 //Serial.print("RPM is ");
 Serial.println(RPM);
}

void count()
{
 now = millis();
 tdiff = (now - lastDebounceTime) ;
 if (tdiff > debounceDelay)
 {
   lastDebounceTime = now;
   //RPM = 60000/tdiff;
   counter_val++;
 }

}
