

class AttractionState extends State
{
    public AttractionState()
    {
        super( "attraction" );
    }


    public void doWhileInState()
    {
        if ( isButtonPressed && !wasButtonPressed ) {
            if ( ldrValue < 256 ) {
                stateHandler.changeStateTo( NIGHT_STATE );
            } else {
                stateHandler.changeStateTo(   DAY_STATE );
            }
        } else {
            if ( stateHandler.milliSecondsInState() % 1000 < 500 ) {
                background( 0 , 255,   0 );
            } else {
                background( 0 , 255, 255 );
            }
        }
    }
}