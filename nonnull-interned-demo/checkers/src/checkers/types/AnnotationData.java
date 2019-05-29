package checkers.types;



import java.util.*;

import javax.lang.model.element.*;
import javax.lang.model.type.*;

import org.checkerframework.framework.qual.DefaultQualifier;
import org.checkerframework.checker.nullness.qual.NonNull;

/**
 * A general representation for annotations used as type qualifiers.
 * Annotations in this representation will most typically come from annotations
 * in Java source code or compiled Java class files. Others may be created for
 * data in which an annotation has not been written but is implicitly present
 * (e.g., a {@code @NonNull} annotation on a {@link String} literal).
 *
 * @see AnnotationFactory
 */
@DefaultQualifier(NonNull.class)
public interface AnnotationData {

    /**
     * @return the type of the annotation
     */
    TypeMirror getType();

    /**
     * @return the location of the annotation
     */
    AnnotationLocation getLocation();

    /**
     * @return the values of the annotation's arguments
     */
    Map<? extends ExecutableElement, ? extends AnnotationValue>
        getValues();
}
