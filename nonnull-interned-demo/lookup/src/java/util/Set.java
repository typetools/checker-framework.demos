package java.util;

import org.checkerframework.checker.nullness.qual.NonNull;

public abstract interface Set<E> extends java.util.Collection<E> {
  public abstract int size();
  public abstract boolean isEmpty();
  public abstract boolean contains(java.lang.Object a1);
  public abstract @NonNull Iterator<E> iterator();
  public abstract @NonNull Object[] toArray();
  public abstract <T> T[] toArray(T[] a1);
  public abstract boolean add(E a1);
  public abstract boolean remove(java.lang.Object a1);
  public abstract boolean containsAll(@NonNull Collection<?> a1);
  public abstract boolean addAll(java.util.Collection<? extends E> a1);
  public abstract boolean retainAll(java.util.Collection<?> a1);
  public abstract boolean removeAll(java.util.Collection<?> a1);
  public abstract void clear();
  public abstract boolean equals(java.lang.Object a1);
  public abstract int hashCode();
}
