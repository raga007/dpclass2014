import org.junit.*;
import static org.junit.Assert.*;
import java.util.*;
import java.util.zip.DataFormatException;

import java.lang.annotation.*;
import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.*;
import java.lang.reflect.*;

public class TestBinaryTreeCanonical {

  @Before
  public void setUp() {
  }

  BinaryTreeCanonical.BinaryTreeNode a = new BinaryTreeCanonical.BinaryTreeNode( 1, null, null );
  BinaryTreeCanonical.BinaryTreeNode b = new BinaryTreeCanonical.BinaryTreeNode( 2, null, null );
  BinaryTreeCanonical.BinaryTreeNode c = new BinaryTreeCanonical.BinaryTreeNode( 3, null, null );
  BinaryTreeCanonical.BinaryTreeNode d = new BinaryTreeCanonical.BinaryTreeNode( 2, null, null );
  BinaryTreeCanonical.BinaryTreeNode e = new BinaryTreeCanonical.BinaryTreeNode( 3, null, null );
  BinaryTreeCanonical.BinaryTreeNode f = new BinaryTreeCanonical.BinaryTreeNode( 1, null, null );

  BinaryTreeCanonical.BinaryTreeNode bDup = new BinaryTreeCanonical.BinaryTreeNode( 2, null, null );

  { // static initializer block
    a.left = b;
    a.right = c;
    d.left = b;
    d.right = e;
    f.left = b;
    f.right = c;
  }

  @Test(timeout=1000)
  public void testFlyweightsAreUnique() {

    BinaryTreeCanonical.BinaryTreeNode t1 = BinaryTreeCanonical.getCanonical(a);
    BinaryTreeCanonical.BinaryTreeNode t2 = BinaryTreeCanonical.getCanonical(d);
    BinaryTreeCanonical.BinaryTreeNode t3 = BinaryTreeCanonical.getCanonical(f);

    assertFalse(t1==t2);
    assertTrue(t1==t3);
  }

  @Test(timeout=1000)
  public void testRightNumberOfFlyweights() {
    List<BinaryTreeCanonical.BinaryTreeNode> Alist = new LinkedList<BinaryTreeCanonical.BinaryTreeNode>();
    Alist.add( a );
    Alist.add( b );
    Alist.add( c );
    Alist.add( d );
    Alist.add( e );
    Alist.add( f );

    List<BinaryTreeCanonical.BinaryTreeNode> Blist = new LinkedList<BinaryTreeCanonical.BinaryTreeNode>();
    for ( BinaryTreeCanonical.BinaryTreeNode n : Alist ) {
      BinaryTreeCanonical.BinaryTreeNode cn = BinaryTreeCanonical.getCanonical( n );
      Blist.add( cn );
    }
    assertEquals(BinaryTreeCanonical.numberOfFlyweightNodes(), 4);
  }
}
