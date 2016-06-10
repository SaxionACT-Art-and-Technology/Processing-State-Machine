

class NightState extends State
{
    State previousState;


    public NightState()
    {
        super( "night" );
    }


    void handleKeyPress( int keyCode )
    {
        stateHandler.changeStateTo( previousState == CITY_STATE ? MOVIE_STATE : CITY_STATE );
    }


    public void enterState( State oldState ) {
        previousState = oldState;
    }


    public void doWhileInState()
    {
        int darkness = (int) map( mouseX, 0, width, 127, 0 );
        background( darkness );
        drawMoon( darkness );
        fill( darkness, darkness, 0 );
        rect( 0, height * 3 / 4 , width,  height / 4 );
    }


    private void drawMoon( int darkness )
    {
        int moonSize = 100;
        float moonAngle = map( mouseX, 0, width,         0, -PI );
        float moonPhase = map( mouseX, 0, width, -moonSize,   0 );
        float x1 = width / 2 + ( width / 2 - moonSize / 2 ) * cos( moonAngle ) ;
        float y1 = 3 * height / 4 + ( 3  * height / 4 - moonSize / 2 ) * sin( moonAngle ) ;
        float x2 = x1 + moonPhase ;
        float y2 = y1 ;
        fill( 128 + darkness / 2 );
        ellipse( x1, y1, moonSize, moonSize );
        fill( darkness );
        ellipse( x2, y2, moonSize, moonSize );
    }
       
}