package java.lang;

import org.checkerframework.checker.nullness.qual.NonNull;
import org.checkerframework.checker.nullness.qual.Nullable;

public class Object{
  public Object() { throw new RuntimeException("skeleton method"); }
  public boolean equals(@Nullable Object a1) { throw new RuntimeException("skeleton method"); }
  public @NonNull String toString() { throw new RuntimeException("skeleton method"); }
  public final @NonNull native Class getClass();
  public final void wait(long a1, int a2) throws java.lang.InterruptedException { throw new RuntimeException("skeleton method"); }
  public final void wait() throws java.lang.InterruptedException { throw new RuntimeException("skeleton method"); }
  public native int hashCode();
}
