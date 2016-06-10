

class StandbyState extends State
{
    public StandbyState()
    {
        super( "standby" );
    }


    public void doWhileInState()
    {
        if ( isButtonPressed && ! wasButtonPressed ) {
            stateHandler.changeStateTo( ATTRACTION_STATE );
        } else {
            background( 0 );
        }
    }
}