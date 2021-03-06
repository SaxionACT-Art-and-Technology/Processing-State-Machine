

import processing.video.*;


class MovieState extends State
{
    Movie myMovie;

    public void enterState( State oldState )
    {
        if ( myMovie == null ) {
            myMovie = new Movie( parent, "small.mp4" );
        }
        myMovie.loop();
    }

    
    void handleKeyPress( int keyCode )
    {
        // no interuption of the movie, if annoying, decomment line below
        // stateHandler.changeState( STANDBY_STATE );
    }


    public void leaveState( State newState )
    {
        if ( myMovie != null ) {
            myMovie.stop();
        }
    }

    
    public MovieState()
    {
        super( "movie" );
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