

class MovingBallState extends State
{
    final int RADIUS = 100;

    void enterState( State oldState )
    {
        isLedOn = true;
    }


    public void doWhileInState()
    {
        if ( stateHandler.secondsInState() > 8 ) {
            stateHandler.changeStateTo( STANDBY_STATE );
        } else {
            background( 255 );
            int redness  = (int) map( potmeterValue, POTMETER_MIN_VALUE, POTMETER_MAX_VALUE, 0, 255 );
            int blueness = 255 - redness;
            int x = (int) map( potmeterValue, POTMETER_MIN_VALUE, POTMETER_MAX_VALUE, RADIUS, width  - RADIUS );
            int y = (int) map( potmeterValue, POTMETER_MIN_VALUE, POTMETER_MAX_VALUE, RADIUS, height - RADIUS );
            fill( redness, 0 , blueness );
            ellipse( x, y, RADIUS*2, RADIUS*2 );
        }
    }
}