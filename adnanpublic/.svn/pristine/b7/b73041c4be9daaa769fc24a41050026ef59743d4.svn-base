import static java.lang.Math.*;
import java.util.Random;
import java.util.List;
import java.util.ArrayList;

// OBSERVER PATTERN
interface Observer {
  public void update(PositionMap pm);
}

class ObserverMap implements Observer {

  public void update(PositionMap pm) {
    System.out.println("New map observed:\n" + pm);
  }

}

interface ObservableMap {
  public void registerObserver(Observer observer);
  public void notifyObservers();
}

class PositionMap implements ObservableMap {
 
  // each entry is a list of robots at that location
  Object state[][];
  List<Observer> obsList = new ArrayList<Observer>();

  public PositionMap(int N) {
    this.state = new ArrayList[N][];
    for (int i = 0; i < N; i++) {
      state[i] = new ArrayList[N];
      for (int j = 0; j < N; j++) {
        state[i][j] = new ArrayList<Robot>();
      }
    }
  }

  // add a robot to that location
  public void setPosition(Position loc, Robot robot) {
    ((ArrayList<Robot>) (state[loc.getX()][loc.getY()])).add(robot);
    notifyObservers();
  }

  public void clearPosition(Position loc) {
    List<Robot> rl = readPosition(loc);
    if ( rl.size() > 0) {
      Robot r = rl.remove( rl.size() -1 );
      r.die();
    }
    notifyObservers();
  }

  public List<Robot> readPosition(Position loc) {
    return (ArrayList<Robot>) state[loc.getX()][loc.getY()];
  }

  public int dimension() {
    return state.length;
  }

  @Override
  public String toString() {
    StringBuffer sb = new StringBuffer();
    int N = state.length;
    for (int i = 0 ; i < N; i++ ) {
      for (int j = 0 ; j < N; j++ ) {
        sb.append(state[i][j]);
      }
      sb.append("\n");
    }
    return sb.toString();
  }

  public void registerObserver(Observer o) {
    obsList.add(o);
  }

  public void notifyObservers() {
    for (Observer o : obsList) {
      o.update(this);
    }
  }

}

class Position {

  private int x;
  private int y;

  public Position(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public void setX(int x) {
    this.x = x;
  }

  public void setY(int y) {
    this.y = y;
  }

  public int getX() {
    return this.x;
  }

  public int getY() {
    return y;
  }

  @Override
  public String toString() {
    return "(" + x + "," + y + ")";
  }

}

// FAVOR INTERFACES OVER IMPLEMENTATIONS
interface Robot {
  public void move(int n, Position p);
  public void destroy(int n);
  public void die();
}

// USE INHERITANCE TO REMOVE DUPLICATE CODE
abstract class AbstractRobot implements Robot {

  private PositionMap map;
  private Position location;
  private boolean liveState = true;
  String name = "noname";

  protected PositionMap getMap() {
    return map;
  }

  public Position getLocation() {
    return location;
  }

  // stackoverflow can-an-abstract-class-have-a-constructor
  public AbstractRobot( String name, PositionMap map ) {
    this.map = map;
    this.location = new Position(0,0);
    this.name = name;
    map.setPosition(location, this);
  }

  public boolean equals(Object o) {
    if (o == null || !(o instanceof Position)) {
      return false;
    }
    Position p = (Position) o;
    return (p.getX() == location.getX() && p.getY() == location.getY());
  }

  protected enum Direction {
    X, Y
  }

  protected static int offset(int numSteps, Position start, Position finish, Direction d) {

    double xDistance =  ((double) finish.getX() - start.getX());
    double yDistance =  ((double) finish.getY() - start.getY());
    double ratio = ((d==Direction.X) ? xDistance : yDistance)/(xDistance+yDistance);
    int distance = (int) (((double)numSteps)*ratio);

    return distance;
  }

  public void move(int numSteps, Position dest) {

    if (liveState == false || location.equals(dest) ) {
      return;
    }

    int xnew = location.getX() + offset(numSteps, location, dest, Direction.X);
    int ynew = location.getY() + offset(numSteps, location, dest, Direction.Y);

    xnew = min(map.dimension(), xnew);
    xnew = max(0,xnew);

    ynew = min(map.dimension(), ynew);
    ynew = max(0,ynew);

    map.clearPosition(location);
    location = new Position(xnew, ynew);
    map.setPosition(location, this);

  }

  public void destroy(int distance) {

    // STRATEGY PATTERN, used in calling destroystrategy
    boolean here = false;
    for (int i = max(0,location.getX() - distance); 
    		i <= min(map.dimension()-1,location.getX() + distance); 
		i++ ) {
      for (int j = max(0,location.getY() - distance); 
      		j <= min(map.dimension()-1,location.getY() + distance); 
		j++ ) {
	if ( i == location.getX() && j == location.getY()) {
	  here = true;
	  map.clearPosition(location);
	}
	destroystrategy(new Position(i,j), map);
	if ( here ) {
	  here = false;
	  map.setPosition(location, this);
	}
      }
    }
  }

  public void die() {
    liveState = false;
  }

  @Override
  public String toString() {
    return name + ", alive = " + liveState + ", " + location;
  }

  public abstract void destroystrategy(Position p, PositionMap map);

}

// destroys one robot at that location
class SingleShotRobot extends AbstractRobot {

  SingleShotRobot(String name, PositionMap pm) {
    super(name, pm);
  }

  public void destroystrategy(Position location, PositionMap map) {
    if ( map.readPosition( location ).size() > 0 ) {
      map.clearPosition( location ); 
    }
  }
}

// destroys all robots at that location
class MultiShotRobot extends AbstractRobot {
  MultiShotRobot(String name, PositionMap pm) {
    super(name, pm);
  }

  public void destroystrategy(Position location, PositionMap map) {
    while ( map.readPosition( location ).size() > 0 ) {
      map.clearPosition( location ); 
    }
  }
}

class RandomRobot {
  private PositionMap map;
  private Position location;
  private Random r = new Random();
  private boolean liveState=true;

  public Position getLocation() {
    return location;
  }

  public PositionMap getMap() {
    return map;
  }

  public void move() {
    int newX = r.nextInt(map.dimension());
    int newY = r.nextInt(map.dimension());
    map.clearPosition(location);
    location = new Position(newX, newY);
  }

  public void destroy() {
    int rndX = r.nextInt(map.dimension());
    int rndY = r.nextInt(map.dimension());
    map.clearPosition(new Position(rndX, rndY));
  }

  public void die() {
    liveState = false;
  }

}

// ADAPTER PATTERN
class RandomRobotAdapter implements Robot {
  private RandomRobot rndRob;

  RandomRobotAdapter( RandomRobot rndRob ) {
    this.rndRob = rndRob;
  }

  public void move(int n, Position p) {
    rndRob.move();
    rndRob.getMap().setPosition(rndRob.getLocation(), this);
  }

  public void destroy(int n) {
    rndRob.destroy();
  }

  public void die() {
    rndRob.die();
  }

}

// DECORATOR PATTERN
class ProfiledRobot implements Robot {
  private Robot robot;
  private int numMoves;
  private int numDestroys;

  public ProfiledRobot( Robot robot ) {
    this.robot = robot;
  }

  public void move(int n, Position dest) {
    numMoves++;
    robot.move(n, dest);
    System.out.println("robot has made " + numMoves + " moves");
  }

  public void destroy(int n) {
    numDestroys++;
    robot.destroy(n);
    System.out.println("robot has made " + numDestroys + " destroys");
  }

  public void die() {
    robot.die();
  }

}

// ABSTRACT FACTORY PATTERN
abstract class AbstractRobotFactory {
  private PositionMap pm;
  public AbstractRobotFactory(PositionMap pm) {
    this.pm = pm;
  }
  public PositionMap getMap() {
    return pm;
  }
  abstract public Robot getSingleShotRobot(String name);
  abstract public Robot getMultiShotRobot(String name);
}

class RobotFactory extends AbstractRobotFactory {

  RobotFactory(PositionMap pm) {
    super(pm);
  }

  public Robot getSingleShotRobot(String name) {
    return new SingleShotRobot(name, getMap());
  }

  public Robot getMultiShotRobot(String name) {
    return new MultiShotRobot(name, getMap());
  }
}

class ProfiledRobotFactory extends AbstractRobotFactory {

  ProfiledRobotFactory(PositionMap pm) {
    super(pm);
  }

  public Robot getSingleShotRobot(String name) {
    return new ProfiledRobot( new SingleShotRobot(name, getMap()) );
  }

  public Robot getMultiShotRobot(String name) {
    return new ProfiledRobot( new MultiShotRobot(name, getMap()) );
  }
}

public class ClassyRobotSimulator {

  public static void simpleSimulation(AbstractRobotFactory af) {
    Robot r1 = af.getSingleShotRobot("r1");
    Robot r2 = af.getMultiShotRobot("r2");
    System.out.println("Step 0\n" + af.getMap());
    r1.move(6, new Position(6,6) );
    System.out.println("Step 1\n" + af.getMap() );
    r2.move(4, new Position(0,5) );
    System.out.println("Step 2\n" + af.getMap() );
    r1.destroy(10);
  }

  public static void main(String[] args) {
    PositionMap pm = new PositionMap(8);
    AbstractRobotFactory af = new RobotFactory(pm); 
    simpleSimulation(af);
    pm = new PositionMap(8);
    Observer obs = new ObserverMap();
    pm.registerObserver( obs );
    af = new ProfiledRobotFactory(pm);
    simpleSimulation(af);

  }
}
