

import processing.serial.*;
import cc.arduino.*;


final int      LDR_PIN = 2; // LDR connected to  analog pin A2.
final int   BUTTON_PIN = 3; // LDR connected to digital pin D3.
final int POTMETER_PIN = 0; // LDR connected to  analog pin A0.

final int      LDR_MIN_VALUE =    0;
final int      LDR_MAX_VALUE = 1023;
final int POTMETER_MIN_VALUE =    0;
final int POTMETER_MAX_VALUE = 1023;

final int   RED_LED_PIN = 5;
final int GREEN_LED_PIN = 6;

int      ldrValue; 
int potmeterValue;

int greenLEDValue  = 0;
int    redLEDValue = 0;

boolean  isButtonPressed = false;
boolean wasButtonPressed = false;

StateHandler stateHandler;

final State    STANDBY_STATE = new    StandbyState();
final State ATTRACTION_STATE = new AttractionState();
final State        DAY_STATE = new        DayState();
final State       CITY_STATE = new       CityState();
final State      MOVIE_STATE = new      MovieState();
final State      NIGHT_STATE = new      NightState();

//static PApplet parent;

Arduino arduino;

 
void setup() {
    //parent = this;
    size( 1280,720 );
    frameRate( 60 );
    noStroke();
    stateHandler = new StateHandler( "State example with arduino" );
    stateHandler.changeStateTo( STANDBY_STATE );
    
    println( "Serial ports[] = " );
    printArray( Arduino.list() );   // Prints out the available serial ports.
    println( "\nArduino ports[] =" );
    printArray( getPossibleArduinoPorts( Arduino.list() ) );
    println( "" );
}

void draw() {
    if ( frameCount % 3 == 0 && isArduinoConnected() ) {
        arduino = getConnectedArduino();    
        readArduinoInputs();
        processData();
        writeArduinoOutputs();
    }


    // arduino0 = getConnectedArduino( 0 );
    // arduino1 = getConnectedArduino( 1 );
    //if ( arduino0 != null && arduino1 != null ) {
}


void readArduinoInputs() {
    // read the analog pin with the LDR (set in the pinLDR variable). 
    // store it in the ldrValue variabele;
         ldrValue   = arduino.analogRead (      LDR_PIN );
    potmeterValue   = arduino.analogRead ( POTMETER_PIN );
    isButtonPressed = arduino.digitalRead(   BUTTON_PIN ) == Arduino.HIGH;
   traceIfChanged( "arduino.digitalRead(   BUTTON_PIN )", arduino.digitalRead(   BUTTON_PIN ) + "" );
    
    
   traceIfChanged( "isButtonPressed", isButtonPressed + "" );
}

void processData() {
  stateHandler.handleState();
  wasButtonPressed = isButtonPressed;
}


void writeArduinoOutputs() {
    arduino.analogWrite (   RED_LED_PIN,   redLEDValue );
    arduino.analogWrite ( GREEN_LED_PIN, greenLEDValue );
    arduino.digitalWrite(            13, Arduino.HIGH  );
} //<>//