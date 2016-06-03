import processing.video.*;



class MovingBallState extends State
{
    final int RADIUS = 100;

    public void doWhileInState()
    {
        if ( stateHandler.secondsInState() > 8 ) {
            stateHandler.changeStateTo( STANDBY_STATE );
        } else {
            background( 255 );
            int redness  = (int) map( mouseY, height, 0, 0, 255 );
            int blueness = 255 - redness;
            int x = (int) map( mouseX, width, 0, RADIUS, width  - RADIUS );
            int y = (int) map( mouseX, width, 0, RADIUS, height - RADIUS );
            fill( redness, 0 , blueness );
            ellipse( x, y, RADIUS*2, RADIUS*2 );
        }
    }
}