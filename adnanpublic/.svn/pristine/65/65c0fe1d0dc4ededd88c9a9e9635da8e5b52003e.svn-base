import static java.lang.Math.*;

class PositionMap {
  int state[][];
  public PositionMap(int N) {
    this.state = new int[N][];
    for (int i = 0; i < N; i++) {
      state[i] = new int[N];
    }
  }
  public void setPosition(Position loc) {
    state[loc.getX()][loc.getY()]++;
  }
  public void clearPosition(Position loc) {
    state[loc.getX()][loc.getY()]--;
  }
  public int readPosition(Position loc) {
    return state[loc.getX()][loc.getY()];
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

class DeterministicRobot  {
  private PositionMap map;
  private Position location;

  public DeterministicRobot( PositionMap map ) {
    this.map = map;
    this.location = new Position(0,0);
    map.setPosition(location);
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

    if (location.equals(dest) ) {
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
    map.setPosition(location);
  }

  public void destroy(int distance) {
    for (int i = max(0,location.getX() - distance); 
    		i <= min(map.dimension()-1,location.getX() + distance); 
		i++ ) {
      for (int j = max(0,location.getY() - distance); 
      		j <= min(map.dimension()-1,location.getY() + distance); 
		j++ ) {
	if ( i == location.getX() && j == location.getY()) {
	  if ( map.readPosition(location) > 1 ) {
	    // something else is at this location, remove it
	    map.clearPosition(location);
	  }
	} else if ( map.readPosition(new Position(i,j)) > 0 ) {
	  map.clearPosition(new Position(i,j));
	}
      }
    }
  }

}

public class RobotSimulator {
  public static void main(String[] args) {
    PositionMap map = new PositionMap(8);
    System.out.println("Step 0\n" + map );
    DeterministicRobot r1 = new DeterministicRobot(map);
    DeterministicRobot r2 = new DeterministicRobot(map);
    r1.move(6, new Position(6,6) );
    System.out.println("Step 1\n" + map );
    r2.move(4, new Position(0,5) );
    System.out.println("Step 2\n" + map );
    r1.destroy(10);
  }
}
