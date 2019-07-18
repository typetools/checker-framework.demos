public class Client {

  /** Return true if this person might be Jackie O. */
  public static boolean isJackieO(Person p) {
    return p.getMaidenName().get().equals("Bouvier");
  }

  public static void main(String[] args) {

    Person elizabethII = new Person("Elizabeth", "Windsor", null);

    if (isJackieO(elizabethII)) {
      System.out.println("That is a surprise!");
    } else {
      System.out.println("They are different people.");
    }
  }
}
