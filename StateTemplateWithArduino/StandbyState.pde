

class StandbyState extends State
{
    void enterState( State oldState )
    {
        isLedOn = false;
    }


    public void doWhileInState()
    {
        
        if ( isButtonPressed && ! wasButtonPressed ) {
            stateHandler.changeStateTo( ATTRACTION_STATE );
        } else {
            background( 0 );
        }
    }


    void leaveState( State oldState )
    {
        isLedOn = true;
    }
}