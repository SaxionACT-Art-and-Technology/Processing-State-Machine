
class CityState extends State
{
    PImage day;
    PImage night;

    public CityState()
    {
        super( "city" );
    }

    public void enterState( State oldState )
    {
        if ( day == null ) {
            day   = loadImage(   "city-day.jpg" );
            night = loadImage( "city-night.jpg" );
        }
    }
    

    public void leaveState( State newState )
    {
        noTint();  // reset the tint fill options, used for transparency
    }


    void handleKeyPress( int keyCode )
    {
        stateHandler.changeStateTo( MOVIE_STATE );
    }


    public void doWhileInState()
    {
        int blendFactor = (int) map( mouseY, 0, height, 0, 255 );
        noTint();        // reset tint fill
        image( day , 0 , 0 , width , height ); 
        tint( 255, blendFactor );  // apply transparency to night image (alpha 0 - 255)
        image( night , 0 , 0 , width , height );
    }
}