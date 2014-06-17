import java.util.Set;
import java.util.HashSet;

public class ThirteenLinks {
  public static void main(String[] args) {
    for ( int i = 1; i < 13; i++ ) {
      for ( int j = 1; j < 13; j++ ) {
        for ( int k = 1; k < 13; k++ ) {
          if ( i + j + k == 13 ) {
            Set<Integer> possibilities = new HashSet<Integer>();
            for( int a = -1; a < 2; a++ ) {
              for( int b = -1; b < 2; b++ ) {
                for( int c = -1; c < 2; c++ ) {
                  int sum = a * i + b * j + c *k;
                  if ( sum > 0 ) {
                    possibilities.add(sum);
                  }
                  if ( i == 1 && j == 3 && k == 9 ) {
                    System.out.println(sum + " = " + a + "*1 " + b + "*3 " + c + "*9 ");
                  }
                }
              }
            }
            if ( possibilities.size() == 13 ) {
              System.out.println("Solution: " + i + ":" + j + ":" + k ); 
            }
          }
        }
      }
    }
  }
}

