import java.io.*;
import java.net.*;
import java.util.concurrent.*;

public class SudokuServer {
  static int PORT = -1;
  // no matter how many concurrent requests you get,
  // do not have more than three solvers running concurrently
  final static int MAXPARALLELTHREADS = 3;

  // this method exists for testing purposes, since
  // we want to clear out the singleton cache for 
  // subsequent junit tests.
  static void resetcache() {
    //TODOBEGIN(DP)
    //TODOEND(DP)
  }

  public static void start(int portNumber ) throws IOException {
    PORT = portNumber;
    Runnable serverThread = new ThreadedSudokuServer();
    Thread t = new Thread( serverThread );
    t.start();
  }
}

//TODOBEGIN(DP)
class ThreadedSudokuServer implements Runnable {
  public void run() {
  }
}
//TODOEND(DP)
