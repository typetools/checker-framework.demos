public class Client {

  /** Return true if this person might be Jackie O. */
  public static boolean isJackieO(Person p) {
    return p.getMaidenName().equals("Bouvier");
  }

  public static void main(String[] args) {

    Person dianaRoss = new Person("Ross", "Diana", null);

    if (isJackieO(dianaRoss)) {
      System.out.println("That is a surprise!");
    } else {
      System.out.println("They are different people.");
    }
  }
}
