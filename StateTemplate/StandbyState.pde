


class StandbyState extends State
{
    void handleKeyPress( int keyCode )
    {
        stateHandler.changeStateTo( ATTRACTION_STATE );
    }
    
    public void doWhileInState()
    {
        background( 0 );
    }
}