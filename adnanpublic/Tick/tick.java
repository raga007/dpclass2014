import java.io.*;
import java.util.zip.*;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class tick {

  public static void readgzip(String fn) throws Exception {
    InputStream fs = new FileInputStream(fn);
    InputStream g = new GZIPInputStream(fs);
    Reader decoder = new InputStreamReader(g, "US-ASCII");
    BufferedReader br = new BufferedReader(decoder);
    String line;
    while((line = br.readLine()) != null) {
      System.out.println(line);
    }
  }



  static String readLineFromStdIn(BufferedReader stdin){  
    try {  
      String input = stdin.readLine();  
      return(input);  
    } catch (java.io.IOException e) {  
      System.out.println(e);   
    }  
    return "This should not have happened";  
  }

  static void processInput(String filename) throws Exception {
    String line;
    int length=0;
    int numlines=0;
    FileReader fr = new FileReader(filename);
    BufferedReader br = new BufferedReader(fr);
    // BufferedReader stdin = new BufferedReader( new InputStreamReader(System.in));  
    // FileOutputStream fos = new FileOutputStream(filename + ".simplify");
    FileWriter fw = new FileWriter(filename + ".simplify");
    BufferedWriter bw = new BufferedWriter(fw);
    PrintWriter pw = new PrintWriter( bw );
    DateFormat df = new SimpleDateFormat("HH:mm:ss.SSS MM/dd/yyyy");
    // while ( (line = readLineFromStdIn(stdin)) != null ) {
    while ((line = br.readLine()) != null) {
      length += line.length(); 
      numlines++;
      // System.out.println("line = " + line);
      String [] field = line.split("\\|");
      String type = field[0];
      if ( type.equals("t") ) {
        //for (String s : field ) {
        //  System.out.print(s + ":");
        //}
        // System.out.println("\n" + field[1]  + "|" + field[2]);
        Date d = df.parse( field[2] + " " + field[1] );
        String symbol = field[3];
        double price = Double.parseDouble( field[4] );
        double volume = Double.parseDouble( field[5] );
        pw.println(type + ":" + d.getTime() + ":" + symbol + ":" + price + ":" + volume );
        // System.out.println("date = " + d.toString());
        // System.out.println("\ndate long = " + d.getTime());
        if (numlines % 1000000 == 0 ) {
          System.out.println("numlines = " + numlines);
        }
      }
    }
    br.close();
    bw.close();
  }

  public static void main(String[] args) throws Exception {
    for (String filename : filelist.names ) {
      try {
        System.out.println("Processing: " + filename + " time: " + new  Date());
        // processInput( "first_10_" + filename );
        processInput( filename );
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
    // readgzip("tick.dat.java-gzip");
    /*
    FileReader fr = new FileReader("tick.dat");
    BufferedReader br = new BufferedReader(fr);
    FileOutputStream fos = new FileOutputStream("tick.dat.java-gzip");
    // BufferedWriter bw = new BufferedWriter(fw);
    GZIPOutputStream gbw = new GZIPOutputStream(fos);
    String line;
    long length = 0;
    long numlines = 0;
    DateFormat df = new SimpleDateFormat("HH:mm:ss.SSS MM/dd/yyyy");

    while((line = br.readLine()) != null) {
      length += line.length(); 
      numlines++;
      String [] field = line.split("\\|");
      // for (String s : field ) System.out.print(s + ":");
      byte[] b = (field[1]  + "|" + field[2]).getBytes();
      gbw.write(b, 0, b.length );
      // System.out.println("\n" + field[1]  + "|" + field[2]);
      Date d = df.parse( field[2] + " " + field[1] );
      // System.out.println("date = " + d.toString());
      // System.out.println("\ndate long = " + d.getTime());
      if (numlines % 10000 == 0 ) {
        System.out.println("numlines = " + numlines);
      }
    } 
    System.out.println("length = " + length);
    System.out.println("numlines = " + numlines);
    */
  }
}
