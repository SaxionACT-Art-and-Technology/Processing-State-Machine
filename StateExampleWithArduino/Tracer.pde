

import java.util.Map;
import java.util.HashMap;
   
private static float start = System.nanoTime();

/**
 * Returns an array as a comma separated string.
 * @param array  A boolean expression.
 * @param count  The error message to use if the assertion fails.
 * @param radix  The power of the numbers in the array.
 
public static String formatArray( array : Array , count : int = -1 , radix : int = 10 )
{
    var max : uint = ( count == -1 ) ? array.length : count < array.length ? count : array.length;
    var arrayString : String = "";
    for ( var i : int = 0 ; i < max ; i++ ) {
        if ( arrayString.length == 0 ) {
            arrayString += array[i].toString( radix );
        } else {
            arrayString += ", " + array[i].toString( radix );
        }
    }
    return arrayString;
}
*/

/**
 * Traces a string preceded with the current time.
 * @param traceMessage  Message to be traced.
 */
public static void traceWithTime( String traceMessage )
{
    float now = ( (long) (timeSinceStart() / 1e4 ) ) / 100.0;  // milliseconds with two decimals
    
    println( now + " > " + traceMessage );
}

/**
 * Returns the number of microseconds since the start of the execution.
 */
public static float timeSinceStart()
{
    return System.nanoTime() - start;
}

/**
 * Returns the number of seconds since the start of the execution.
 */
public static int timeSinceStartInSeconds()
{
    return (int) ( timeSinceStart() / 1e9 );
}

/**
 * Returns the number of seconds since the start of the execution.
 */
public static long timeSinceStartInMilliseconds()
{
    return (long) ( timeSinceStart() / 1e6 );
}


/**
 * Returns the number of seconds since the start of the execution.
 */
public static long timeSinceStartInMicroseconds()
{
    return (long) ( timeSinceStart() / 1e3 );
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