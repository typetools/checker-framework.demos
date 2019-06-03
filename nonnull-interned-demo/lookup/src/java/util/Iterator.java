package java.util;

import org.checkerframework.checker.nullness.qual.NonNull;

public abstract interface Iterator<E> {
  public abstract boolean hasNext();
  public abstract @NonNull E next();
  public abstract void remove();
}
