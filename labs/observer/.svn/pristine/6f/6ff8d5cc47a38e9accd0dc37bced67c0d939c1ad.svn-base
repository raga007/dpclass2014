import twitter4j.*;
import java.util.Set;
import java.util.Map;
import java.util.HashSet;
import java.util.HashMap;
import java.util.Map.Entry;

public class TwitterListener implements StatusListener, Subject {

  private Map<Observer, Set<String>> mapObservers
    = new HashMap<Observer, Set<String>>();

  @Override 
  public void onStatus(Status status) {
    // you need to write some codes here 
  }

  @Override
  public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
    System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
  }

  @Override
  public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
    System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
  }

  @Override
  public void onScrubGeo(long userId, long upToStatusId) {
    System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  }

  @Override
  public void onStallWarning(StallWarning warning) {
    System.out.println("Got stall warning:" + warning);
  }

  @Override
  public void onException(Exception ex) {
    ex.printStackTrace();
  }

  @Override // implementing method defined in Subject interface
  public void notifyObservers(String text) {
    // you need to write some codes here 
  }

  @Override // implementing method defined in Subject interface
  public boolean removeObserver(Observer observer) {
    boolean result = false;
    // you need to write some codes here 

    return result;
  }

  @Override  // implementing method defined in Subject interface
  public boolean registerObserver(Observer observer, String track) {
    boolean result = false;
    // you need to write some codes here 

    return result;
  }
}
