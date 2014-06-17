class IncrementThread implements Runnable {
  public void run() {for ( int i = 0 ; i < TwoThreadIncrement.N; i++) { TwoThreadIncrement.counter++;} }
}

public class TwoThreadIncrement {
  public static int counter;
  public static int N = 100;

  public static void main(String[] args) {
    if (args.length > 0) {
      N = new Integer(args[0]);
    }
    Thread T1 = new Thread( new IncrementThread() );
    Thread T2 = new Thread( new  IncrementThread() );

    T1.start();
    T2.start();
    try {
      T1.join();
      T2.join();
    } catch (Exception e) {
      e.printStackTrace();
    }
    System.out.println(counter);
  }
}
