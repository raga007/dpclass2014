import java.util.LinkedList;

class Producer implements Runnable {
  public void run() {
    int n=0;
    while (true) {
      int item = n++;
      int size;
      synchronized (PC.Q) {
        size = PC.Q.size(); 
      }
      if (size == PC.Q_MAX) {
        try {
          System.out.println("Producer sleeping");
          Thread.sleep(PC.LONGTIME);
	} catch (InterruptedException e) {
          System.out.println("Producer interrupted");
	}
      }
      synchronized (PC.Q) {
        PC.Q.addLast(item); 
        System.out.println("Producer added " + item);
	if (PC.Q.size() == 1) {
          PC.c.interrupt();
	}
      }
    }
  }
}

class Consumer implements Runnable {
  public void run() {
    while (true) {
      int size;
      synchronized (PC.Q) {
        size = PC.Q.size(); 
      }
      if (size == 0) {
        try {
          System.out.println("Consumer sleeping");
	  Thread.sleep(PC.LONGTIME);
	} catch (InterruptedException e) {
          System.out.println("Consumer interrupted");
	}
      }
      int item;
      synchronized (PC.Q) {
        item = PC.Q.removeFirst();
        System.out.println("Consumer removed " + item);
	if (PC.Q.size() == PC.Q_MAX-1) {
          PC.p.interrupt();
	}
      }
    }
  }
}

public class PC {
  public final static Object lock = new Object();
  public final static LinkedList<Integer> Q = new LinkedList<Integer>();
  public final static int Q_MAX = 2;
  public final static int LONGTIME = 1000000000;
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
