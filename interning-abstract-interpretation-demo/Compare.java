public class Compare {

  public static void main(String ... args) {
    compareStr(args[0], "Foo");

    String[] args2 = {"Foo"};
    compareStr(args2[0], "Foo");

    String str1 = "Foo";
    compareStr(str1, "Foo");

    String str2 = "F" + "oo";
    compareStr(str2, "Foo");
    
    String tmp = "F";
    String str3 = tmp + "oo";
    compareStr(str3, "Foo");

    compareInt(1, 1);
    compareInt(Integer.valueOf(1), Integer.valueOf(1));
    compareInt(new Integer(1), new Integer(1));

    compareInt(100, 100);   
    compareInt(1000, 1000);   
  }

  private static void compareStr(String str1, String str2) {
    if (str1 == str2) {
      System.out.println("Strings are equal: " + str1 + " <> " + str2);
    } else {
      System.out.println("Strings are NOT equal: " + str1 + " <> " + str2);
    }
  }

  private static void compareInt(Integer i1, Integer i2) {
    if (i1 == i2) {
      System.out.println("Integers are equal: " + i1 + " <> " + i2);
    } else {
      System.out.println("Integers are NOT equal: " + i1 + " <> " + i2);
    }
  }
}
