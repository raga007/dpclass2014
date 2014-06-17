import java.net.*;
import java.io.*;
import java.util.*;

public class InstrumentedAirportScraper implements AirportScraperInterface {
  AirportScraperInterface a;

  private Map<String,Double> cache;
  private Map<String,Integer> mostCommonCalls;

  public InstrumentedAirportScraper(String src) {
    a = new AirportScraper(src);
    cache = new HashMap<String,Double>();
    mostCommonCalls = new HashMap<String,Integer>();
  }

  //@Override
  public double lookupDistance( String dest ) {
    int count = 1;
    if ( mostCommonCalls.containsKey(dest) ) {
      count = 1 + mostCommonCalls.get(dest);
    }
    mostCommonCalls.put(dest,count);
    Double result = cache.get(dest);
    if (result != null) {
      return result;
    }
    result = a.lookupDistance(dest);
    cache.put(dest, result);
    return result;
  }

  //@Override
  public String toString() {
    return a.toString() + ",\tCache size = " + cache.size();
  }

  public List<String> mostCommonDestinations() {

    List<String> result = new ArrayList<String>();
    // Transfer as List and sort it
    ArrayList<Map.Entry<String, Integer>> l = new ArrayList(mostCommonCalls.entrySet());
    Collections.sort(l, 
      new Comparator<Map.Entry<String, Integer>>() {
        public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
          int r = o2.getValue().compareTo(o1.getValue());
	  if ( r != 0 ) {
	    return r;
	  }
	  return o1.getKey().compareTo(o2.getKey());
        }
      });
    for (Map.Entry<String, Integer> e : l ) {
      result.add(e.getKey() + ":" + e.getValue());
    }
    return result;
  }

}

