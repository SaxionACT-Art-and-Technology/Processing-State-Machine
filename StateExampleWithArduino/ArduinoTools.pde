/*
Helper Functions so an Arduino is automatically detected. 
You don't have to use this.
*/

import java.util.regex.Pattern;
import java.util.regex.Matcher;


      int nrOfSerialPorts = 0;
final int NR_OF_ARDUINOS  = 2;

PApplet parent = this;

Arduino[] arduinos = new Arduino[ NR_OF_ARDUINOS ];


Arduino getConnectedArduino() {
    return getConnectedArduino( 0 );
}



Arduino getConnectedArduino( int index ) {
    return arduinos[ index ];
}


void initializeArduino( String[] arduinoPorts ) {
    initializeArduino( arduinoPorts, 0 );
}


void initializeArduino( String[] arduinoPorts, int index ) {
    arduinos[index] = new Arduino( this, arduinoPorts[index], 57600 );
    setupArduinoPins( index );
}


void setupArduinoPins( int index ) {
    switch( index ) {
        case 0: setupArduino0_Pins(); break;
        case 1: setupArduino0_Pins(); break;  // copy this line for more firmata Arduinos
        default:
            println( "Error, no setup for index " + index );
            System.exit( 0 );
    }
}


void setupArduino0_Pins() {
    println( "Initializing Arduino 0" );
    Arduino arduino = arduinos[0];
    arduino.pinMode(  2, Arduino.INPUT  ); // button 
    arduino.pinMode(  3, Arduino.INPUT  ); // button 
    arduino.pinMode(  4, Arduino.SERVO  ); // servo
    arduino.pinMode(  5, Arduino.OUTPUT ); // output (PWM)
    arduino.pinMode(  6, Arduino.OUTPUT ); // output (PWM)
    arduino.pinMode(  7, Arduino.SERVO  ); // servo
    arduino.pinMode(  8, Arduino.SERVO  ); // servo
    arduino.pinMode(  9, Arduino.OUTPUT ); // output (PWM)
    arduino.pinMode( 10, Arduino.OUTPUT ); // output (PWM)
    arduino.pinMode( 11, Arduino.OUTPUT ); // output (PWM)
    arduino.pinMode( 12, Arduino.OUTPUT ); // output
    arduino.pinMode( 13, Arduino.OUTPUT ); // output
}


void setupArduino1_Pins() {
    println( "Initializing Arduino 1" );
    Arduino arduino = arduinos[1];
    //arduino.pinMode(  2, Arduino.INPUT  ); // INPUT, OUTPUT, SERVO
    //arduino.pinMode(  3, Arduino.INPUT  ); // INPUT, OUTPUT, SERVO (PWM)
    //arduino.pinMode(  4, Arduino.SERVO  ); // INPUT, OUTPUT, SERVO
    //arduino.pinMode(  5, Arduino.OUTPUT ); // INPUT, OUTPUT, SERVO (PWM)
    //arduino.pinMode(  6, Arduino.OUTPUT ); // INPUT, OUTPUT, SERVO (PWM)
    //arduino.pinMode(  7, Arduino.SERVO  ); // INPUT, OUTPUT, SERVO
    //arduino.pinMode(  8, Arduino.SERVO  ); // INPUT, OUTPUT, SERVO
    //arduino.pinMode(  9, Arduino.OUTPUT ); // INPUT, OUTPUT, SERVO (PWM)  main SERVO pin
    //arduino.pinMode( 10, Arduino.OUTPUT ); // INPUT, OUTPUT, SERVO (PWM) minor SERVO pin
    //arduino.pinMode( 11, Arduino.OUTPUT ); // INPUT, OUTPUT, SERVO (PWM)
    //arduino.pinMode( 12, Arduino.OUTPUT ); // INPUT, OUTPUT, SERVO
    //arduino.pinMode( 13, Arduino.OUTPUT ); // INPUT, OUTPUT, SERVO
}


boolean isArduinoConnected() {
    return isArduinoConnected( 0 );
}


boolean isArduinoConnected( int index ) {
  
    boolean isConnected = false;
  
    String[] ports = Arduino.list();
    
    if ( nrOfSerialPorts != ports.length && arduino != null ) {
        arduino.dispose();
        arduinos[index] = null;
    }
    
    if ( arduinos[index] == null && ports.length > 0 && ( nrOfSerialPorts == 0 || nrOfSerialPorts == ports.length ) ) {
        
        println("");
        println("Your Arduino is connected to the port(s) that display 'true'");
        
        String[] arduinoPorts = getPossibleArduinoPorts( ports );
        
        if ( arduinoPorts.length > index ) {
            initializeArduino( arduinoPorts, index );
            nrOfSerialPorts = ports.length;
            isConnected = true;
        } else {
            println("no matches found");
        }
    } else {
        String[] arduinoPorts = getPossibleArduinoPorts( ports );
        
        if ( arduinoPorts.length > index ) {
            isConnected = true;
        }
    }
        
    
    return isConnected;
}


String[] getPossibleArduinoPorts( String[] ports )
{
    String[] matches = {};
    int nrOfMatches = 0;
    Pattern pattern = null;
    Pattern    modemPattern = Pattern.compile( ".*usbmodem[\056A-Za-z0-9]+"        );
    Pattern  cumodemPattern = Pattern.compile( ".*cu\056usbmodem[\056A-Za-z0-9]+"  );
    Pattern   serialPattern = Pattern.compile( ".*usbserial[\056A-Za-z0-9]+"       );
    Pattern cuserialPattern = Pattern.compile( ".*cu\056usbserial[\056A-Za-z0-9]+" );
    Pattern  comPortPattern = Pattern.compile( "COM[0-9]+"                         );
   
           if ( ( nrOfMatches = getNrOfMatches( ports,  cumodemPattern ) ) > 0 ) {
        pattern = cumodemPattern;
    } else if ( ( nrOfMatches = getNrOfMatches( ports, cuserialPattern ) ) > 0 ) {
        pattern = cuserialPattern;
    } else if ( ( nrOfMatches = getNrOfMatches( ports,    modemPattern ) ) > 0 ) {
        pattern = modemPattern;
    } else if ( ( nrOfMatches = getNrOfMatches( ports,   serialPattern ) ) > 0 ) {
        pattern = serialPattern;
    } else if ( ( nrOfMatches = getNrOfMatches( ports,  comPortPattern ) ) > 0 ) {
        pattern = comPortPattern;
    }
    
    if ( nrOfMatches > 0 ) {
        matches = getMatches( ports, pattern, nrOfMatches );
    }
    
    return matches;
}


int getNrOfMatches( String[] ports, Pattern pattern )
{
    int nrOfMatches = 0;
    for ( int i = 0 ; i < ports.length ; i++ ) {
         Matcher matcher = pattern.matcher( ports[i] );
         if ( matcher.matches() ) {
             nrOfMatches++;
         }
    }
    
    return nrOfMatches;
}


String[] getMatches( String[] ports, Pattern pattern, int nr ) {
    int nrOfMatches = 0;
    String[] matches = new String[nr];
    for ( int i = 0 ; i < ports.length ; i++ ) {
         Matcher matcher = pattern.matcher( ports[i] );
         if ( matcher.matches() ) {
             matches[nrOfMatches++] = ports[i];
         }
    }
    
    return matches;
}