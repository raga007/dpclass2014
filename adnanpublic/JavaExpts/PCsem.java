import java.util.LinkedList;
import java.util.concurrent.Semaphore;

class Producer implements Runnable {
  public void run() {
    int n=0;
    int item;
    while (true) {
      item = n++;
      System.out.println("Producer to add " + item);
      try {
        PCsem.spaces.acquire();
      } catch (Exception e) {
        e.printStackTrace();
      }
      synchronized (PCsem.Q) {
        PCsem.Q.addLast(item);
      }
      PCsem.items.release();
    } 
  }
}

class Consumer implements Runnable {
  public void run() {
    int item;
    while (true) {
      try {
        PCsem.items.acquire();
      } catch (Exception e) {
        e.printStackTrace();
      }
      synchronized (PCsem.Q) {
        item = PCsem.Q.removeFirst();
      }	 
      PCsem.spaces.release();

      System.out.println("Consumer got " + item);
    }
  }
}

public class PCsem {

  public final static int Q_MAX = 2;
  public final static int LONGTIME = 1000000000;

  public final static Semaphore mutex = new Semaphore(1);
  public final static Semaphore items = new Semaphore(0);
  public final static Semaphore spaces = new Semaphore(Q_MAX);

  public final static LinkedList<Integer> Q = new LinkedList<Integer>();

  public static Thread p;
  public static Thread c;

  public static void main(String[] args) {
    p = new Thread( new Producer() );
    c = new Thread( new Consumer() );
    p.start(); c.start();
    try {
      p.join(); c.join();
    } catch (Exception e) {
    }
  }
}
