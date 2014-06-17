import java.util.*;

public class DecoratorDemo {

  public static void print(AirportScraper a) {
    System.out.println(a.toString());
  }

  static long startTime = System.currentTimeMillis();

  static void execTime() {
    long currentTime = System.currentTimeMillis();
    long elapseTime = currentTime - startTime;
    System.out.println("time in ms to last execTime call = " + elapseTime );
    startTime = currentTime;
  }

  public static void main(String[] args) {
    AirportScraper a = new AirportScraper("AUS");
    String dest = "IAH";
    long startTime = System.currentTimeMillis();
    double d = a.lookupDistance(dest);
    execTime();
    System.out.println("Distance to " + dest + " is " + d);
    print(a);

    InstrumentedAirportScraper b = new InstrumentedAirportScraper("AUS");
    d = b.lookupDistance(dest);
    execTime();
    System.out.println("Distance to " + dest + " is " + d);
    d = b.lookupDistance(dest);
    execTime();
    System.out.println("Distance to " + dest + " is " + d);
    dest = "JFK";
    d = b.lookupDistance(dest);
    dest = "CDG";
    d = b.lookupDistance(dest);
    dest = "JFK";
    d = b.lookupDistance(dest);
    dest = "BLQ";
    d = b.lookupDistance(dest);
    dest = "JFK";
    d = b.lookupDistance(dest);

    List<String> m = b.mostCommonDestinations();
    for ( String s : m ) {
      System.out.print(s + "\t" );
    }
    System.out.println();
    print(b);
  }
}
