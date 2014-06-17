import java.util.Random;
import java.util.Set;
import java.util.HashSet;

class MockDataServiceProvider {
  private final static int N = 1000;
  private static Random r = new Random();
  public static int fetch() {
    int t = r.nextInt(N);
    try {
      Thread.sleep(t);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return r.nextInt(N);
  }
}

class Observable {
  Set<Observer> observers = new HashSet<Observer>();
  private int data;

  public int getData() { return data; }

  public void setData(int x) { data = x; notifyObservers(); }

  public void notifyObservers() {
    for ( Observer observer : observers ) {
      observer.execute(this);
    }
  }

  public void add(Observer o) {
    observers.add(o);
  }

  public void remove(Observer o) {
    observers.remove(o);
  }

}

class Observer {
  public void execute(Observable observable) {
    System.out.println(observable.getData());
    if ( observable.getData() % 10 == 0 ) {
      leave(observable);
    }
  }

  public void join(Observable o) {
    o.add(this);    
  }

  public void leave(Observable o) {
    o.remove(this);    
  }
}

public class ObserverDemo {

  public static void main(String[] args) {
    Observer o1 = new Observer();
    Observer o2 = new Observer();
    Observable observable = new Observable();
    o1.join(observable);
    o2.join(observable);
    for ( int i = 0; i < 10; i++ ) {
      observable.setData( MockDataServiceProvider.fetch() );
    }
  }
}
