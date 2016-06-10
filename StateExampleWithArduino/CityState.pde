

class CityState extends State
{
    State  previousState;
    PImage day;
    PImage night;

    public CityState()
    {
        super( "city" );
    }

    public void enterState( State oldState )
    {
        previousState = oldState;
        if ( day == null ) {
            day   = loadImage(   "city-day.jpg" );
            night = loadImage( "city-night.jpg" );
        }
    }
    

    public void leaveState( State newState )
    {
        noTint();  // reset the tint fill options, used for transparency
    }


    public void doWhileInState()
    {
        if ( isButtonPressed && !wasButtonPressed ) {
            stateHandler.changeStateTo( previousState == DAY_STATE ? NIGHT_STATE : DAY_STATE );
        } else {
            int blendFactor = (int) map( ldrValue, LDR_MIN_VALUE, LDR_MAX_VALUE, 255, 0 );
            // we can use constrain to prevent that numbers get higher then 255
            // or lower then 0 (because the ldrMin and ldrMax can depend on the situation). 
            blendFactor = constrain( blendFactor , 0 , 255 );
            drawCity( blendFactor );
        }
    }
    
    public void drawCity( int blendFactor )
    {
        noTint();        // reset tint fill
        image( day , 0 , 0 , width , height ); 
        tint( 255, blendFactor );  // apply transparency to night image (alpha 0 - 255)
        image( night , 0 , 0 , width , height );
    }
}