// Template for the state machine with an Arduino
//


import processing.serial.*;
import cc.arduino.*;

StateHandler stateHandler;

final State     STANDBY_STATE = new    StandbyState();
final State  ATTRACTION_STATE = new AttractionState();
final State MOVING_BALL_STATE = new MovingBallState();


Arduino arduino;

final int   BUTTON_PIN = 3; // LDR connected to digital pin D2.
final int POTMETER_PIN = 0; // LDR connected to  analog pin A0.

final int POTMETER_MIN_VALUE =    0;
final int POTMETER_MAX_VALUE = 1023;

int potmeterValue;
int previousPotmeterValue;

boolean  isButtonPressed = false;
boolean wasButtonPressed = false;

boolean isLedOn = false;

int lastTimeActivityWasDetected = 0;

void setup() {
    size( 1280,720 );
    noStroke();
    stateHandler = new StateHandler( "Moving ball template" );
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
}


void processData() {
    checkActivityAndGoToStandbyIfInactiveForTooLong();
    stateHandler.handleState();
    wasButtonPressed = isButtonPressed;
}


void checkActivityAndGoToStandbyIfInactiveForTooLong()
{
    int now = millis();
    if ( isButtonPressed ) {
        lastTimeActivityWasDetected = now;
    }
 
    if ( now - lastTimeActivityWasDetected > 10000 ) {
        stateHandler.changeStateTo( STANDBY_STATE );
    }
}


void readArduinoInputs() {
    potmeterValue   = arduino.analogRead ( POTMETER_PIN );
    isButtonPressed = arduino.digitalRead(   BUTTON_PIN ) == Arduino.HIGH;
    
    traceIfChanged( "isButtonPressed", isButtonPressed + "" );
}


void writeArduinoOutputs() {
    arduino.digitalWrite( 13, isLedOn ? Arduino.HIGH : Arduino.LOW );
}