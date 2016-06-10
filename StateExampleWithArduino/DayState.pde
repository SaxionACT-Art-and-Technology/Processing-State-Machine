

class DayState extends State
{
    State previousState;


    public DayState()
    {
        super( "day" );
    }


    public void enterState( State oldState )
    {
        previousState = oldState;
    }


    public void doWhileInState()
    {
        if ( isButtonPressed && !wasButtonPressed ) {
            stateHandler.changeStateTo( previousState == CITY_STATE ? MOVIE_STATE : CITY_STATE );
        } else {
            int brightness = (int) map( ldrValue, LDR_MIN_VALUE, LDR_MAX_VALUE, 128, 255 );
            
            background( 0, brightness, brightness );
            fill( brightness, brightness, 0 );
            drawSun();
            fill( 0, brightness, 0 );
            rect( 0, height * 3 / 4 , width,  height / 4 );
            greenLEDValue = brightness;
        }
    }


    void leaveState( State newState )
    {
        greenLEDValue = 0;
    }


    void drawSun()
    {
        int sunSize = 100;
        float sunAngle = map( potmeterValue, POTMETER_MIN_VALUE, POTMETER_MAX_VALUE, 0, -PI );
        float x = width / 2 + ( width / 2 - sunSize / 2 ) * cos( sunAngle ) ;
        float y = 3 * height / 4 + ( 3 * height / 4 - sunSize / 2 ) * sin( sunAngle ) ;
        ellipse( x, y, sunSize, sunSize );
    }
}