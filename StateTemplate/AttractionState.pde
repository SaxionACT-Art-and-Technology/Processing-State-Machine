


class AttractionState extends State
{
    public AttractionState()
    {
        super( "attraction" );
    }


    void handleKeyPress( int keyCode )
    {
        stateHandler.changeStateTo( MOVING_BALL_STATE );
    }
    
    public void doWhileInState()
    {
        if ( stateHandler.milliSecondsInState() % 1000 < 500 ) {
            background( 0 ,   0, 255 );
        } else {
            background( 0 , 255, 255 );
        }
    }
}