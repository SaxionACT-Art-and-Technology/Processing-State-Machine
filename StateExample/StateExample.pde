// Example for the State machine
//


StateHandler stateHandler;

final State    STANDBY_STATE = new    StandbyState();
final State ATTRACTION_STATE = new AttractionState();
final State        DAY_STATE = new        DayState();
final State       CITY_STATE = new       CityState();
final State      MOVIE_STATE = new      MovieState();
final State      NIGHT_STATE = new      NightState();


PApplet parent = this;


void setup()
{
    fullScreen();
    //size( 1280,720 );
    noStroke();
    stateHandler = new StateHandler( "State Example" );
    stateHandler.changeStateTo( STANDBY_STATE );
}

void draw()
{
    stateHandler.handleState();
} //<>//