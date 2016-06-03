
// Change/remove these function if you want to program your 
// own mouseClicked or keyPressed functions

void mouseClicked()
{
    stateHandler.mouseClicked();
}

void keyPressed()
{
    stateHandler.keyPressed();
}


class State
{
    private String name;

    protected State( String stateName )
    {
        name = stateName;
        println( "new State() : " + name );
    }


    protected State()
    {
        String className = this.getClass().getSimpleName();
        name = className;
         println( "new State() : " + name );
    }


    String getName() { return name; }
    
    
    // Empty methods, no actions except when defined in a derived class
    
    
    void enterState( State oldState )
    {
    }

    
    public void doWhileInState()
    {
    }


    void leaveState( State newState )
    {
    }


    void handleKeyPress( int keyCode )
    {
    }
    
    
    void handleMouseClick()
    {
    }
}


class StateHandler
{
    private String  name;
    private State   currentState      = null;
    private State   nextState         = null;
    private Boolean isActionCompleted = true;
    private long    nsAtStateStart;

    protected StateHandler( String handlerName )
    {
        name = handlerName;
    }


    String getName()             { return name;                                                 }
    String getStateName()        { return currentState != null ? currentState.getName() : "" ;  }
    long   secondsInState()      { return ( System.nanoTime() - nsAtStateStart ) / 1000000000 ; }
    long   milliSecondsInState() { return ( System.nanoTime() - nsAtStateStart ) /    1000000 ; }



    void mouseClicked()
    {
        if ( isActionCompleted ) {
            isActionCompleted = false;
            currentState.handleMouseClick();
            isActionCompleted = true;
        } else {
            println( "SKIPPED MouseClicked()" );
        }
    }


    void keyPressed()
    {
        if ( isActionCompleted ) {
            //println( "keyCode=" + keyCode );
            isActionCompleted = false;
            currentState.handleKeyPress( keyCode );
            isActionCompleted = true;
        } else {
            println( "SKIPPED keyPressed()" );
        }
    }

    void handleState()
    {
        if ( currentState != null ) {
            currentState.doWhileInState();
            changeStateIfNecessary();
            traceIfChanged( name , getStateName() );  // remove for no tracing
        }
    }


    public void changeStateTo( State newState )
    {
        if ( currentState != newState && newState != null ) {
            nsAtStateStart = System.nanoTime();
            nextState = newState;
            if ( currentState == null ) {
                changeStateIfNecessary();
            }
        }
    }

   
    private void changeStateIfNecessary()
    {
        if ( nextState != null ) {
            if ( currentState != null ) {
                currentState.leaveState( nextState );
            }
            nextState.enterState( currentState );
            currentState = nextState;
            nextState = null;
        }
    }
}