import twitter4j.*;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.LinkedHashSet;

public class TBuck {
  public static void main (String[] args) {
    TwitterListener listener = new TwitterListener(); 

    TwitterStream twitterStream = new TwitterStreamFactory().getInstance();
    twitterStream.addListener(listener);
    Map<String, User> mapUsers= new HashMap<String, User>();

    Scanner sc = new Scanner(System.in);
    List<Long> follow = new ArrayList<Long>();

    long[] followArray = new long[follow.size()];
    LinkedHashSet<String> track = new LinkedHashSet<String>();

    while (true) {
      String[] cmd = sc.nextLine().split("\\s+");

      if (cmd[0].equals("quit") || cmd[0].equals("q")) {
        System.exit(0);
      } else if (cmd[0].equals("user")) {
        // add user
        if (mapUsers.containsKey(cmd[1])) {
          System.out.printf("User %s already present, ignoring add user\n", cmd[1]);
          continue; 
        }    
        User user = new User(cmd[1]);
        mapUsers.put(cmd[1], user);
      } else if (cmd[0].equals("sub")) {
        // subscribe
        User user = mapUsers.get(cmd[1]);

        if (user == null) {
          System.out.printf("User %s does NOT exist, ignoring subcribe\n", cmd[1]);
          continue; 
        }
        if (!listener.registerObserver(user, cmd[2])) {
          System.out.printf("User %s has subscribed %s before\n", cmd[1], cmd[2]);
          continue;
        }
        if (track.contains(cmd[2])) {
          continue; 
        }
        track.add(cmd[2]);
        String[] trackArray = track.toArray(new String[track.size()]);
        twitterStream.filter(new FilterQuery(0, followArray, trackArray));
      } else if (cmd[0].equals("unsub")) {
        // unsubscribe
        User user = mapUsers.get(cmd[1]);

        if (user == null) {
          System.out.printf("User %s does NOT exist, ignoring unsubscribe\n", cmd[1]);
          continue; 
        }
        listener.removeObserver(user); 
      }
    }
  }
}

