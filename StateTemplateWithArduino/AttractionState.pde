


class AttractionState extends State
{
    public void doWhileInState()
    {
        if ( isButtonPressed && !wasButtonPressed ) {
            stateHandler.changeStateTo( MOVING_BALL_STATE );
        } else {
            if ( stateHandler.milliSecondsInState() % 1000 < 500 ) {
                background( 0 , 255,   0 );
                isLedOn = false;
            } else {
                background( 0 , 255, 255 );
                isLedOn = true;
            }
        }
    }
}