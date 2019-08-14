JAVACHECK=$t/checker-framework-branch-master/checker/bin/javac

run: compile
	java -cp . Client

compile:
	@echo "javac *.java"
	@${JAVACHECK} *.java

typecheck:
	@echo "javac -processor nullness *.java"
	@${JAVACHECK} -processor nullness *.java

format:
	run-google-java-format.py *.java
