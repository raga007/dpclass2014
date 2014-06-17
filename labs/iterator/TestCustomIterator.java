import org.junit.*;
import static org.junit.Assert.*;
import java.util.Iterator;

public class TestCustomIterator{

  @Before
  public void setUp() {
  }

  @Test(timeout=1000)
  public void testStudentIterator() {
    Student [] testCase = Student.createTestArray();
    Iterator<Student> berkeleyIterator = 
        new CustomIterator.StudentIteratorBySchool(testCase, "Berkeley");
    assertEquals(berkeleyIterator.next().toString(), "Aardvark Smith,3.5,18,Berkeley");
    assertEquals(berkeleyIterator.next().toString(), "Matt Biondi,3.3,22,Berkeley");
    assertFalse(berkeleyIterator.hasNext() );

    Iterator<Student> mitIterator = 
        new CustomIterator.StudentIteratorBySchool(testCase, "MIT");
    assertEquals(mitIterator.next().toString(), "Imran Aziz,3.6,20,MIT");
    assertFalse(mitIterator.hasNext() );

    Iterator<Student> stanfordIterator = 
        new CustomIterator.StudentIteratorBySchool(testCase, "Stanford");
    assertFalse(stanfordIterator.hasNext() );
  }

  @Test(timeout=1000)
  public void testPredicatedIterator() {
    Student[] testCase = Student.createTestArray();
    Iterator<Student> berkeleyIterator = 
      new CustomIterator.StudentIteratorPredicated(
        new CustomIterator.StudentPredicate() {
          public boolean check(Student student) {
	    return (student.school == "Berkeley");
	  }
	}, testCase);

   assertEquals(berkeleyIterator.next().toString(), "Aardvark Smith,3.5,18,Berkeley");
   assertEquals(berkeleyIterator.next().toString(), "Matt Biondi,3.3,22,Berkeley");
   assertFalse(berkeleyIterator.hasNext() );

    
  }
}
