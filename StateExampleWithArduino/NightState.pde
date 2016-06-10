

class NightState extends State
{
    State previousState;


    public NightState()
    {
        super( "night" );
    }


    public void enterState( State oldState ) {
        previousState = oldState;
    }


    public void doWhileInState()
    {
        if ( isButtonPressed && !wasButtonPressed ) {
            stateHandler.changeStateTo( previousState == CITY_STATE ? MOVIE_STATE : CITY_STATE );
        } else {
            int darkness = (int) map( potmeterValue, POTMETER_MIN_VALUE, POTMETER_MAX_VALUE, 127, 0 );
            traceIfChanged( darkness + "" , "darkness" );
            background( darkness );
            drawMoon( darkness );
            fill( darkness, darkness, 0 );
            rect( 0, height * 3 / 4 , width,  height / 4 );
            redLEDValue = darkness * 2;
        }
    }


    void leaveState( State newState )
    {
        redLEDValue = 0;
    }


    private void drawMoon( int darkness )
    {
        int   moonSize  = 100;
        float moonAngle = map( potmeterValue, POTMETER_MIN_VALUE, POTMETER_MAX_VALUE,         0, -PI );
        float moonPhase = map( potmeterValue, POTMETER_MIN_VALUE, POTMETER_MAX_VALUE, -moonSize,   0 );
        float x1 = width / 2 + ( width / 2 - moonSize / 2 ) * cos( moonAngle ) ;
        float y1 = 3 * height / 4 + ( 3  * height / 4 - moonSize / 2 ) * sin( moonAngle ) ;
        float x2 = x1 + moonPhase ;
        float y2 = y1 ;
        fill( 128 + darkness / 2 );
        ellipse( x1, y1, moonSize, moonSize );
        fill( darkness );
        ellipse( x2, y2, moonSize, moonSize );
    }
}