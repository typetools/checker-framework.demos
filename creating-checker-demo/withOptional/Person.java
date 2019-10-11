import java.util.Optional;
import org.checkerframework.checker.nullness.qual.Nullable;
import org.checkerframework.dataflow.qual.Pure;

public class Person {
  String familyName;
  String givenName;
  /** Family name before marriage. May be null. */
  @Nullable String maidenName;

  Person(String familyName, String givenName, @Nullable String maidenName) {
    this.familyName = familyName;
    this.givenName = givenName;
    this.maidenName = maidenName;
  }

  @Pure
  String getFamilyName() {
    return familyName;
  }

  @Pure
  String getGivenName() {
    return givenName;
  }

  @Pure
  Optional<String> getMaidenName() {
    return Optional.ofNullable(maidenName);
  }
}
