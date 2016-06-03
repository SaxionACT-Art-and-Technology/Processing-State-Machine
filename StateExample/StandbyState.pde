


class StandbyState extends State
{
    public StandbyState()
    {
        super( "standby" );
    }


    void handleKeyPress( int keyCode )
    {
        stateHandler.changeStateTo( ATTRACTION_STATE );
    }


    public void doWhileInState()
    {
        background( 0 );
    }
}