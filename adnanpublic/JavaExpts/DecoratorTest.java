import org.junit.*;
import static org.junit.Assert.*;
import java.util.*;
import java.util.zip.DataFormatException;

import java.lang.annotation.*;
import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.*;
import java.lang.reflect.*;


public class DecoratorTest {

  @Before
  public void setUp() {
  }

  @AfterClass
  public static void oneTimeTearDown() {
  }

  @Test(timeout=1000) 
  public void bt1() {
    AirportScraperInterface a = new AirportScraper("AUS");
    long startTime = System.currentTimeMillis();
    double d = a.lookupDistance("IAH");
    assertEquals(d, 139.8, 0.1);
  }

  @Test(timeout=1000) 
  public void bt2() {
    AirportScraperInterface b = new InstrumentedAirportScraper(
          new AirportScraper("AUS"));
    double d = b.lookupDistance("IAH");
    assertEquals(d, 139.8, 0.1);
  }

  @Test(timeout=1000) 
  public void bt3() {
    AirportScraperInterface c = new InstrumentedAirportScraper(
          new AirportScraper("AUS"));
    double d = c.lookupDistance("IAH");
    assertEquals(d, 139.81, 0.1);
    d = c.lookupDistance("IAH");
    assertEquals(d, 139.8, 0.1);
  }


  // takes a few 100ms per call without cache, so 
  // 100 calls with bad cache will timeout
  @Test(timeout=1000) 
  public void bt4() {
    AirportScraperInterface a = new InstrumentedAirportScraper(
        new AirportScraper("AUS"));
    for ( int i = 0 ; i < 100; i++ ) {
      double d = a.lookupDistance("IAH");
      assertEquals(d, 139.81,0.1);
    }
  }

  @Test(timeout=4000) 
  public void bt5() {
    double d;
    String dest = "IAH";
    InstrumentedAirportScraper b = new InstrumentedAirportScraper(
        new AirportScraper("AUS"));
    d = b.lookupDistance(dest);
    d = b.lookupDistance(dest);
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
    List<String> commonLookups = b.mostCommonDestinations();

    List<String> expectedResult = new ArrayList<String>();
    expectedResult.add("JFK:3");
    expectedResult.add("IAH:2");
    expectedResult.add("BLQ:1");
    expectedResult.add("CDG:1");

    assertEquals(commonLookups, expectedResult);
  }
}
