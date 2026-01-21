import java.util.Optional;

public class Client {

  /** Return true if this person might be Jackie O. */
  public static boolean isJackieO(Person p) {
    Optional<String> mname = p.getMaidenName();
    return mname.get().equals("Bouvier");
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
