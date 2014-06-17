import org.junit.*;
import static org.junit.Assert.*;

public class Poker5CardTest {

  @Test
  // 3 Aces v. 3 Kings
  public void t1() {
    Hand h0 = new Hand( new Card(Suit.CLUB, Value.ACE),
                        new Card(Suit.HEART, Value.ACE),
                        new Card(Suit.DIAMOND, Value.ACE),
                        new Card(Suit.SPADE, Value.EIGHT),
                        new Card(Suit.CLUB, Value.FIVE));
    Hand h1 = new Hand( new Card(Suit.CLUB, Value.KING),
                        new Card(Suit.HEART, Value.KING),
                        new Card(Suit.DIAMOND, Value.KING),
                        new Card(Suit.CLUB, Value.EIGHT),
                        new Card(Suit.SPADE, Value.FIVE));
    int cmp = new HandComparator().compare(h0,h1);
    assertTrue(cmp<0);
  }

  @Test
  // Ace High v. 3 of a Kind
  public void t2() {
    Hand h0 = new Hand( new Card(Suit.CLUB, Value.ACE),
                        new Card(Suit.HEART, Value.TWO),
                        new Card(Suit.DIAMOND, Value.FIVE),
                        new Card(Suit.SPADE, Value.THREE),
                        new Card(Suit.DIAMOND, Value.SIX) );
    Hand h1 = new Hand( new Card(Suit.CLUB, Value.KING),
                        new Card(Suit.HEART, Value.KING),
                        new Card(Suit.DIAMOND, Value.KING),
                        new Card(Suit.SPADE, Value.TWO),
                        new Card(Suit.DIAMOND, Value.FIVE) );
    int cmp = new HandComparator().compare(h0,h1);
    assertTrue(cmp>0);
  }

  @Test
  // Flush v. Two Pair
  public void t3() {
    Hand h0 = new Hand( new Card(Suit.CLUB, Value.FOUR),
                        new Card(Suit.CLUB, Value.TWO),
                        new Card(Suit.CLUB, Value.THREE), 
                        new Card(Suit.CLUB, Value.SIX),
                        new Card(Suit.CLUB, Value.JACK) );
    Hand h1 = new Hand( new Card(Suit.CLUB, Value.ACE),
                        new Card(Suit.HEART, Value.TWO),
                        new Card(Suit.DIAMOND, Value.FOUR), 
                        new Card(Suit.HEART, Value.TWO),
                        new Card(Suit.SPADE, Value.FOUR) );
    int cmp = new HandComparator().compare(h0,h1);
    assertTrue(cmp<0);
  }
  
  @Test
  // Straight Flush v. Straight
  public void t4() {
    Hand h0 = new Hand( new Card(Suit.CLUB, Value.ACE),
                        new Card(Suit.CLUB, Value.TWO),
                        new Card(Suit.CLUB, Value.THREE),
                        new Card(Suit.CLUB, Value.FOUR),
                        new Card(Suit.CLUB, Value.FIVE) );
    Hand h1 = new Hand( new Card(Suit.DIAMOND, Value.ACE),
                        new Card(Suit.HEART, Value.TWO),
                        new Card(Suit.DIAMOND, Value.THREE), 
                        new Card(Suit.DIAMOND, Value.FOUR),
                        new Card(Suit.DIAMOND, Value.FIVE) );
    int cmp = new HandComparator().compare(h0,h1);
    assertTrue(cmp<0);
  }

  @Test
  // Two Pair v. Pair
  public void t5() {
    Hand h0 = new Hand( new Card(Suit.CLUB, Value.FIVE),
                        new Card(Suit.DIAMOND, Value.FOUR),
                        new Card(Suit.SPADE, Value.FOUR),
                        new Card(Suit.SPADE, Value.FIVE),
                        new Card(Suit.SPADE, Value.THREE) );
    Hand h1 = new Hand( new Card(Suit.CLUB, Value.ACE),
                        new Card(Suit.HEART, Value.ACE),
                        new Card(Suit.SPADE, Value.KING),
                        new Card(Suit.HEART, Value.TWO),
                        new Card(Suit.DIAMOND, Value.FOUR) );
    int cmp = new HandComparator().compare(h0,h1);
    assertTrue(cmp<0);
  }

  @Test
  // Full House v. 4 of a Kind
  public void t6() {
    Hand h0 = new Hand( new Card(Suit.DIAMOND, Value.FIVE),
                        new Card(Suit.CLUB, Value.TWO),
                        new Card(Suit.SPADE, Value.TWO),
                        new Card(Suit.DIAMOND, Value.TWO),
                        new Card(Suit.CLUB, Value.FIVE) );
    Hand h1 = new Hand( new Card(Suit.CLUB, Value.ACE),
                        new Card(Suit.HEART, Value.THREE),
                        new Card(Suit.SPADE, Value.THREE),
                        new Card(Suit.CLUB, Value.THREE),
                        new Card(Suit.DIAMOND, Value.THREE) );
    int cmp = new HandComparator().compare(h0,h1);
    assertTrue(cmp>0);
  }

  @Test
  // Straight v. Full House
  public void t7() {
    Hand h0 = new Hand( new Card(Suit.DIAMOND, Value.ACE),
                        new Card(Suit.CLUB, Value.TWO),
                        new Card(Suit.SPADE, Value.THREE),
                        new Card(Suit.CLUB, Value.FOUR),
                        new Card(Suit.HEART, Value.FIVE) );
    Hand h1 = new Hand( new Card(Suit.SPADE, Value.FOUR),
                        new Card(Suit.HEART, Value.FOUR),
                        new Card(Suit.DIAMOND, Value.FOUR),
                        new Card(Suit.DIAMOND, Value.JACK),
                        new Card(Suit.CLUB, Value.JACK) );
    int cmp = new HandComparator().compare(h0,h1);
    assertTrue(cmp>0);
  }

  @Test
  // 3 of a Kind vs. Two Pair
  public void t8() {
    Hand h0 = new Hand( new Card(Suit.DIAMOND, Value.ACE),
                        new Card(Suit.CLUB, Value.ACE),
                        new Card(Suit.SPADE, Value.KING),
                        new Card(Suit.CLUB, Value.TEN),
                        new Card(Suit.CLUB, Value.KING) );
    Hand h1 = new Hand( new Card(Suit.CLUB, Value.SEVEN),
                        new Card(Suit.HEART, Value.SEVEN),
                        new Card(Suit.SPADE, Value.TWO),
                        new Card(Suit.DIAMOND, Value.QUEEN),
                        new Card(Suit.DIAMOND, Value.SEVEN) );
    int cmp = new HandComparator().compare(h0,h1);
    assertTrue(cmp>0);
  }

  @Test
  // Queen High Straight v. 6 High Straight
  public void t9() {
    Hand h0 = new Hand( new Card(Suit.CLUB, Value.QUEEN),
                        new Card(Suit.SPADE, Value.JACK),
                        new Card(Suit.DIAMOND, Value.TEN),
                        new Card(Suit.CLUB, Value.NINE),
                        new Card(Suit.HEART, Value.EIGHT) );
    Hand h1 = new Hand( new Card(Suit.CLUB, Value.SIX),
                        new Card(Suit.HEART, Value.FIVE),
                        new Card(Suit.HEART, Value.FOUR),
                        new Card(Suit.HEART, Value.THREE),
                        new Card(Suit.CLUB, Value.TWO) );
    int cmp = new HandComparator().compare(h0,h1);
    assertTrue(cmp<0);
  }

  @Test
  // 10 High v. King High 
  public void t10() {
    Hand h0 = new Hand( new Card(Suit.CLUB, Value.TEN),
                        new Card(Suit.SPADE, Value.EIGHT),
                        new Card(Suit.DIAMOND, Value.TWO),
                        new Card(Suit.CLUB, Value.NINE),
                        new Card(Suit.HEART, Value.FOUR) );
    Hand h1 = new Hand( new Card(Suit.CLUB, Value.THREE),
                        new Card(Suit.HEART, Value.SEVEN),
                        new Card(Suit.HEART, Value.KING),
                        new Card(Suit.HEART, Value.JACK),
                        new Card(Suit.CLUB, Value.TWO) );
    int cmp = new HandComparator().compare(h0,h1);
    assertTrue(cmp>0);
  }

  @Test
  // Pair 10s v. Pair 8s
  public void t11() {
    Hand h0 = new Hand( new Card(Suit.CLUB, Value.QUEEN),
                        new Card(Suit.SPADE, Value.JACK),
                        new Card(Suit.DIAMOND, Value.TEN),
                        new Card(Suit.CLUB, Value.NINE),
                        new Card(Suit.HEART, Value.TEN) );
    Hand h1 = new Hand( new Card(Suit.CLUB, Value.EIGHT),
                        new Card(Suit.HEART, Value.FIVE),
                        new Card(Suit.HEART, Value.FOUR),
                        new Card(Suit.HEART, Value.EIGHT),
                        new Card(Suit.CLUB, Value.TWO) );
    int cmp = new HandComparator().compare(h0,h1);
    assertTrue(cmp<0);
  }

  @Test
  // Two Pair Queens and 5s v. Two Pair Queens 8s
  public void t12() {
    Hand h0 = new Hand( new Card(Suit.CLUB, Value.QUEEN),
                        new Card(Suit.SPADE, Value.JACK),
                        new Card(Suit.DIAMOND, Value.FIVE),
                        new Card(Suit.CLUB, Value.FIVE),
                        new Card(Suit.HEART, Value.QUEEN) );
    Hand h1 = new Hand( new Card(Suit.CLUB, Value.EIGHT),
                        new Card(Suit.SPADE, Value.QUEEN),
                        new Card(Suit.DIAMOND, Value.QUEEN),
                        new Card(Suit.HEART, Value.EIGHT),
                        new Card(Suit.CLUB, Value.TWO) );
    int cmp = new HandComparator().compare(h0,h1);
    assertTrue(cmp>0);
  }

  @Test
  // Odds of 4 aces beating 4 kings is 1
  public void t13() {
    PartialHand h0 = new PartialHand( new Card(Suit.CLUB, Value.ACE),
                        new Card(Suit.SPADE, Value.ACE),
                        new Card(Suit.DIAMOND, Value.ACE),
                        new Card(Suit.CLUB, Value.ACE) );
    PartialHand h1 = new PartialHand( new Card(Suit.CLUB, Value.KING),
                        new Card(Suit.SPADE, Value.KING),
                        new Card(Suit.DIAMOND, Value.KING),
                        new Card(Suit.CLUB, Value.KING) );
    assertEquals(0.0, HandComparator.oddsOfWinning( h0, h1 ) );
  }

}
