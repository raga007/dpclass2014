import java.util.concurrent.Semaphore;
import java.util.ArrayList;
import java.util.List;

public class CSP {
  // agent
  static Semaphore agentSem = new Semaphore(1);
  static Semaphore tobacco = new Semaphore(0);
  static Semaphore paper = new Semaphore(0);
  static Semaphore matches = new Semaphore(0);

  static class agentA implements Runnable {
    public void run() {
      while (true) {
        try {
          agentSem.acquire();
	} catch (InterruptedException e) {
	  e.printStackTrace();
	}
	System.out.println("agentA about to release tobacco and paper");
        tobacco.release();
        paper.release();  
      }
    }
  }

  static class agentB implements Runnable {
    public void run() {
      while (true) {
        try {
          agentSem.acquire(); 
	} catch (InterruptedException e) {
	  e.printStackTrace();
	}
	System.out.println("agentB about to release tobacco and matches");
        tobacco.release();
        matches.release(); 
      }
    }
  }

  static class agentC implements Runnable {
    public void run() {
      while (true) {
        try {
          agentSem.acquire();
	} catch (InterruptedException e) {
	  e.printStackTrace();
	}
	System.out.println("agentC about to release paper and matches");
        paper.release();
        matches.release();
      }
    }
  }

  static class smokerMatches implements Runnable {
    public void run() {
      while (true) {
        try {
          tobacco.acquire();
          paper.acquire();
	} catch (Exception e) {
	  e.printStackTrace();
	}
        System.out.println("smoker with matches ready");
        agentSem.release();
      }
    }
  }

  static class smokerTobacco implements Runnable {
    public void run() {
      while (true) {
        try {
          matches.acquire();
          paper.acquire();
	} catch (Exception e) {
	  e.printStackTrace();
	}
        System.out.println("smoker with tobacco ready");
        agentSem.release();
      }
    }
  }

  static class smokerPaper implements Runnable {
    public void run() {
      while (true) {
        try {
          tobacco.acquire();
          matches.acquire();
	} catch (Exception e) {
	  e.printStackTrace();
	}
        System.out.println("smoker with paper ready");
        agentSem.release();
      }
    }
  }

  public static void main(String[] args) {
     List<Thread> tList = new ArrayList<Thread>();
     tList.add(new Thread( new CSP.agentA())); 
     tList.add(new Thread( new CSP.agentB())); 
     tList.add(new Thread( new CSP.agentC()));
     tList.add(new Thread( new CSP.smokerMatches()));
     tList.add(new Thread( new CSP.smokerTobacco()));
     tList.add(new Thread( new CSP.smokerPaper()));
     for( Thread t : tList ) {
       t.start();
     }
     try {
       for ( Thread t : tList ) {
         t.join();
       }
     } catch (Exception e) {
       e.printStackTrace();
     }

  }
}
