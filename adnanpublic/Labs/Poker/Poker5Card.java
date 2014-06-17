// Card class
// Suit class (enum)
// Value class (enum)
// Hand class
// Deck class
// compare method
// use to rank hands
// hands can be 5 or 7 cards (can use inheritance here)
// have a best5 method
// have a simulation method, how likely is your 7 cards to beat the best 5 in 7 other cards?

import java.util.Comparator;
import java.util.Arrays;
import java.util.Random;

enum Suit {
  HEART, CLUB, SPADE, DIAMOND
}

enum Value {
  ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING, ACE
}

class Card {
  Suit suit;
  Value value;
  Card( Suit s, Value v) {
    suit = s;
    value = v;
  }
  static Random r = new Random(0);
  static Card randomCard() {
    int numSuits = Suit.values().length;
    int numValues = Value.values().length;
    return new Card( Suit.values()[ r.nextInt( numSuits )], 
                      Value.values()[ r.nextInt( numValues )] );
  }
}

class CardCompare implements Comparator<Card> {
  private CardCompare() { };
  static public final CardCompare compareObject = new CardCompare();
  public int compare(Card s1, Card s2) {
    return s1.value.ordinal() - s2.value.ordinal();
  }
}

class Hand {
  Card cards[] = new Card[5];

  Hand( Card a, Card b, Card c, Card d, Card e) {
    cards[0] = a;
    cards[1] = b;
    cards[2] = c;
    cards[3] = d;
    cards[4] = e;
    Arrays.sort(cards,
        // descending sort
        CardCompare.compareObject
    );
  }

  boolean is4OfAKind() {
	    return (cards[0].value == cards[1].value && cards[1].value == cards[2].value && cards[2].value == cards[3].value)
	    		|| (cards[1].value == cards[2].value && cards[2].value == cards[3].value && cards[3].value == cards[4].value);
	  }
  
  boolean is3OfAKind() {
    return (cards[0].value == cards[1].value && cards[1].value == cards[2].value)
    		|| (cards[1].value == cards[2].value && cards[2].value == cards[3].value)
    		|| (cards[2].value == cards[3].value && cards[3].value == cards[4].value);
  }

  boolean isFlush() {
    return cards[0].suit == cards[1].suit && cards[1].suit == cards[2].suit && cards[2].suit == cards[3].suit && cards[3].suit == cards[4].suit;
  }
  
  boolean isStraight() {
    return cards[0].value.ordinal() == cards[1].value.ordinal() - 1
          && cards[1].value.ordinal() == cards[2].value.ordinal() - 1
          && cards[2].value.ordinal() == cards[3].value.ordinal() - 1
          && cards[3].value.ordinal() == cards[4].value.ordinal() - 1
        || cards[0].value == Value.TWO && cards[1].value == Value.THREE && cards[2].value == Value.FOUR && cards[3].value == Value.FIVE && cards[4].value == Value.ACE;
  }

  boolean isStraightFlush() {
    return isFlush() && isStraight();
  }

  boolean isTwo() {
    return (cards[0].value == cards[1].value)
      || (cards[1].value == cards[2].value)
      || (cards[2].value == cards[3].value)
      || (cards[3].value == cards[4].value);
  }
  
  boolean isTwoPair() {
	    return (cards[0].value == cards[1].value && cards[2].value == cards[3].value)
	      || (cards[1].value == cards[2].value && cards[3].value == cards[4].value)
	      || (cards[0].value == cards[1].value && cards[3].value == cards[4].value);
  }
  
  boolean isFullHouse() {
	    return (cards[0].value == cards[1].value && cards[1].value == cards[2].value && cards[3].value == cards[4].value)
	      || (cards[0].value == cards[1].value && cards[2].value == cards[3].value && cards[3].value == cards[4].value);
  }
  
}


class PartialHand {
  Card[] cards;
  PartialHand(Card... C) {
    Card[] hand = new Card[C.length];
    int i = 0;
    for (Card c : C ) {
      hand[i++] = c;
    }
  }
}

class HandComparator {

  private static int highCheck( boolean b0, boolean b1, Hand h0, Hand h1 ) {
    if ( !b0 && b1 ) {
      return 1;
    } else if ( b0 && !b1 ) {
      return -1;
    } else if (b0 && b1) {
      int v0 = h0.cards[0].value.ordinal();
      int v1 = h1.cards[0].value.ordinal();
      return v1 - v0;
    }
    return 0;
  }

  private static int compare3OfAKind(Hand h0, Hand h1) {
    boolean b0 = h0.is3OfAKind();
    boolean b1 = h1.is3OfAKind();
    if ( !b0 && b1 ) {
        return 1;
      } else if ( b0 && !b1 ) {
        return -1;
      } else if (b0 && b1) {
        int v0 = h0.cards[2].value.ordinal();
        int v1 = h1.cards[2].value.ordinal();
        return v1 - v0;
      }
      return 0;
  }

  private static int compareStraightFlush(Hand h0, Hand h1) {
    boolean b0 = h0.isStraightFlush();
    boolean b1 = h1.isStraightFlush();
    return highCheck( b0, b1, h0, h1 );
  }

  private static int compareFlush(Hand h0, Hand h1) {
     boolean b0 = h0.isFlush();
     boolean b1 = h1.isFlush();
     if ( !b0 && b1 ) {
       return 1;
     } else if ( b0 && !b1 ) {
       return -1;
     } else if ( b0 && b1 ) {
       return compareOne(h0, h1);
     } else {
       return 0;
     }
   }

  private static int compareStraight(Hand h0, Hand h1) {
     boolean b0 = h0.isStraight();
     boolean b1 = h1.isStraight();
     if ( !b0 && b1 ) {
       return 1;
     } else if ( b0 && !b1 ) {
       return -1;
     } else if ( b0 && b1 ) {
       int v0 = h0.cards[0].value.ordinal();
       int v1 = h1.cards[0].value.ordinal();
       // special ace, 2, 3 straight; watch out for confusion with 2,3,4
       if ( v0 == Value.TWO.ordinal() && h0.cards[4].value.ordinal() == Value.ACE.ordinal() ) {
         if ( v1 == Value.TWO.ordinal() && h1.cards[4].value.ordinal() == Value.ACE.ordinal() ) {
           return 0;
         } else {
           return 1;
         }
       } else if ( v1 == Value.TWO.ordinal() && h1.cards[4].value.ordinal() == Value.ACE.ordinal() ) {
         return -1;
       }
       return h1.cards[4].value.ordinal() - h0.cards[4].value.ordinal();
     }
     return 0;
 }

  private static int compareTwo(Hand h0, Hand h1) {
    boolean b0 = h0.isTwo();
    boolean b1 = h1.isTwo();
    if ( !b0 && b1 ) {
      return 1;
    } else if ( b0 && !b1 ) {
      return -1;
    } else if ( b0 && b1 ) {
    	
      // Find pair value for h0
      int max0;
      if(h0.cards[0].value == h0.cards[1].value) {
    	  max0 = h0.cards[1].value.ordinal();
      } else if(h0.cards[1].value == h0.cards[2].value) {
    	  max0 = h0.cards[2].value.ordinal();
      } else if(h0.cards[2].value == h0.cards[3].value) {
    	  max0 = h0.cards[3].value.ordinal();
      } else {
    	  max0 = h0.cards[4].value.ordinal();
      }
      
      // Find pair value for h1
      int max1;
      if(h1.cards[0].value == h1.cards[1].value) {
    	  max1 = h1.cards[1].value.ordinal();
      } else if(h1.cards[1].value == h1.cards[2].value) {
    	  max1 = h1.cards[2].value.ordinal();
      } else if(h1.cards[2].value == h1.cards[3].value) {
    	  max1 = h1.cards[3].value.ordinal();
      } else {
    	  max1 = h1.cards[4].value.ordinal();
      }
    	
      // check if tied on the pair
      if ( max0 != max1 ) {
        return max1 - max0;
      } else {
        // tied on pair
        return compareOne(h0, h1);
      }
    }
    return 0;
  }

  private static int compareOne(Hand h0, Hand h1) {
    for ( int i = h0.cards.length-1; i >= 0; i-- ) {
      int v0 = h0.cards[i].value.ordinal();
      int v1 = h1.cards[i].value.ordinal();
      if ( v0 != v1 ) {
        return v1 - v0;
      }
    }
    return 0;
  }
  
  private static int compareTwoPair(Hand h0, Hand h1) {
	    boolean b0 = h0.isTwoPair();
	    boolean b1 = h1.isTwoPair();
	    if ( !b0 && b1 ) {
	      return 1;
	    } else if ( b0 && !b1 ) {
	      return -1;
	    } else if ( b0 && b1 ) {
	    	
	      // Find pair values for h0
	      int high0;
	      int low0;
	      if(h0.cards[0].value == h0.cards[1].value && h0.cards[2].value == h0.cards[3].value) {
	    	  high0 = h0.cards[3].value.ordinal();
	    	  low0 = h0.cards[1].value.ordinal();
	      } else if(h0.cards[1].value == h0.cards[2].value && h0.cards[3].value == h0.cards[4].value) {
	    	  high0 = h0.cards[4].value.ordinal();
	    	  low0 = h0.cards[2].value.ordinal();
	      } else {
	    	  high0 = h0.cards[4].value.ordinal();
	    	  low0 = h0.cards[1].value.ordinal();
	      }
	      
	      // Find pair values for h1
	      int high1;
	      int low1;
	      if(h1.cards[0].value == h1.cards[1].value && h1.cards[2].value == h1.cards[3].value) {
	    	  high1 = h0.cards[3].value.ordinal();
	    	  low1 = h0.cards[1].value.ordinal();
	      } else if(h1.cards[1].value == h1.cards[2].value && h1.cards[3].value == h1.cards[4].value) {
	    	  high1 = h0.cards[4].value.ordinal();
	    	  low1 = h0.cards[2].value.ordinal();
	      } else {
	    	  high1 = h0.cards[4].value.ordinal();
	    	  low1 = h0.cards[1].value.ordinal();
	      }
	    	
	      // check if tied on the high pair
	      if ( high0 != high1 ) {
	        return high1 - high0;
	      // check if tied on the low pair
	      } else if ( low0 != low1 ) {
	        return low1 - low0;
	      } else {
	        // tied on pair
	        return compareOne(h0, h1);
	      }
	    }
	    return 0;
  }
  
  private static int compareFullHouse(Hand h0, Hand h1) {
	  boolean b0 = h0.isFullHouse();
	  boolean b1 = h1.isFullHouse();
	  if ( !b0 && b1 ) {
		  return 1;
	  } else if ( b0 && !b1 ) {
		  return -1;
	  } else if (b0 && b1) {
		  int v0 = h0.cards[2].value.ordinal();
	      int v1 = h1.cards[2].value.ordinal();
	      return v1 - v0;
	  }
	  return 0;
  }
  
  private static int compareFour(Hand h0, Hand h1) {
	  boolean b0 = h0.is4OfAKind();
	  boolean b1 = h1.is4OfAKind();
	  if ( !b0 && b1 ) {
		  return 1;
	  } else if ( b0 && !b1 ) {
		  return -1;
	  } else if (b0 && b1) {
		  int v0 = h0.cards[2].value.ordinal();
	      int v1 = h1.cards[2].value.ordinal();
	      return v1 - v0;
	  }
	  return 0;
  }

  public int compare(Hand h0, Hand h1) {
    int cmp;
    // use short circuit evaluation
    if ( (0 != ( cmp = compareStraightFlush(h0,h1) ) )
          || (0 != ( cmp = compareFour(h0,h1) ) )
          || (0 != ( cmp = compareFullHouse(h0,h1) ) )
          || (0 != ( cmp = compareFlush(h0,h1) ) )
          || (0 != ( cmp = compareStraight(h0,h1) ) )
          || (0 != ( cmp = compare3OfAKind(h0,h1) ) )
          || (0 != ( cmp = compareTwoPair(h0,h1) ) )
          || (0 != ( cmp = compareTwo(h0,h1) ) )
          || (0 != ( cmp = compareOne (h0,h1) ) ) ) {
    }
    return cmp;
  }


  public static double oddsOfWinning(PartialHand h0, PartialHand h1) {
    Card[] tmp0 = new Card[5];
    Card[] tmp1 = new Card[5];
    int i = 0;
    for ( Card c : h0.cards ) {
      tmp0[i++] = c;
    }
    i = 0;
    for ( Card c : h1.cards ) {
      tmp1[i++] = c;
    }
    int win = 0;
    int tie = 0;
    int loss = 0;
    int numMissingCards = 5 - i;
    for ( int j = 0 ; j < 1000; j++ ) {
      for ( int k = numMissingCards; k < 5; k++ ) {
        tmp0[k] = Card.randomCard();
        tmp1[k] = Card.randomCard();
      }
      Hand h0complete = new Hand( tmp0[0], tmp0[1], tmp0[2], tmp0[3], tmp0[4] );
      Hand h1complete = new Hand( tmp1[0], tmp1[1], tmp1[2], tmp1[3], tmp1[4] );
      int cmp = new HandComparator().compare(h0complete,h1complete); 
      if ( cmp < 0 ) {
        win++;
      } else if ( cmp > 0 ) {
        loss++;
      } else {
        tie++;
      }
    }
    return ((double) win)/ ( win + loss + tie);
  }
}
