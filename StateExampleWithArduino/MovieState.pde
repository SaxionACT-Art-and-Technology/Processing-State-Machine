import processing.video.*;


class MovieState extends State
{
    Movie myMovie;

    public MovieState()
    {
        super( "movie" );
    }


    public void enterState( State oldState )
    {
        if ( myMovie == null ) {
            myMovie = new Movie( parent, "small.mp4" );
        }
        myMovie.loop();
        background( 0 );  // to see that the state is changed
    }

    
    public void leaveState( State newState )
    {
        if ( myMovie != null ) {
            myMovie.stop();
        }
    }

    
    public void doWhileInState()
    {
        if ( stateHandler.secondsInState() > 5.8 ) {
            stateHandler.changeStateTo( STANDBY_STATE );
        } else {
            if ( myMovie.available() ) {
                image( myMovie, 0, 0, width, height );
                myMovie.read();
            }
        }
    }
}