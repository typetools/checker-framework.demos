package utilMDE;

import org.checkerframework.framework.qual.DefaultQualifier;
import org.checkerframework.checker.nullness.qual.NonNull;

/**
 * Interface for things that make boolean decisions.
 * This is inspired by java.io.FilenameFilter.
 **/
@DefaultQualifier(NonNull.class)
public interface Filter<T> {
  /** Tests whether a specified Object satisfies the filter. */
  boolean accept(T o);
}
