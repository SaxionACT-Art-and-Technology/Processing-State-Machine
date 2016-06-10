

class DayState extends State
{
    State previousState;


    public DayState()
    {
        super( "day" );
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
        // trick to have the maximum (255) in the middle and twilight (128) at the edges
        int brightness = 255 - (int) abs( map( mouseX, 0, width, -128, 128 ) );
        
        background( 0, brightness, brightness );
        fill( brightness, brightness, 0 );
        drawSun();
        fill( 0, brightness, 0 );
        rect( 0, height * 3 / 4 , width,  height / 4 );
    }


    void drawSun()
    {
        int sunSize = 100;
        float sunAngle = map( mouseX, width, 0, 0, -PI );
        float x =      width / 2 + (      width / 2 - sunSize / 2 ) * cos( sunAngle ) ;
        float y = 3 * height / 4 + ( 3 * height / 4 - sunSize / 2 ) * sin( sunAngle ) ;
        ellipse( x, y, sunSize, sunSize );
    }
}