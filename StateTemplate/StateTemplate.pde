


StateHandler stateHandler;

final State     STANDBY_STATE = new    StandbyState();
final State  ATTRACTION_STATE = new AttractionState();
final State MOVING_BALL_STATE = new MovingBallState();


void setup() {
    size( 1280,720 );
    noStroke();
    stateHandler = new StateHandler( "Moving ball template" );
    stateHandler.changeStateTo( STANDBY_STATE );
}


void draw() {
  stateHandler.handleState();
}