import java.util.Map;
import java.util.HashMap;
   
private static float start = System.nanoTime();

/**
 * Traces a string preceded with the current time.
 * @param traceMessage  Message to be traced.
 */
public static void traceWithTime( String traceMessage )
{
    float now = timeSinceStartInSeconds();
    
    println( now + " > " + traceMessage );
}

/**
 * Returns the number of seconds since the start of the execution.
 */
public static int timeSinceStartInSeconds()
{
    return (int) ( ( System.nanoTime() - start ) / 1e9 );
}

private static Map<String,String> logid2line = new HashMap<String,String>();

/**
 * Only logs data associated with an id, if and only if the *data* has changed.
 */
public static void traceIfChanged( String id , String logLine )
{
    if ( !logid2line.containsKey(id) || !logid2line.get(id).equals( logLine ) ) {
        println( id + " = " + logLine );
        logid2line.put( id, logLine );
    }
}