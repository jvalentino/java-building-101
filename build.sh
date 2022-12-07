#!/bin/bash
rm -rf build || true
mkdir build

# main
echo "Compiling classes..."
mkdir build/classes
javac -d build/classes \
    src/main/java/example/java/gradle/lib/Library.java \
    src/main/java/example/java/gradle/lib/Main.java
echo ""

# compile test classes
echo "Compiling test classes..."
mkdir build/test-classes
javac -d build/test-classes \
    -cp test-lib/junit-platform-console-standalone-1.9.1.jar \
    src/main/java/example/java/gradle/lib/Library.java \
    src/main/java/example/java/gradle/lib/Main.java \
    src/test/java/example/java/gradle/lib/LibraryTest.java 
echo " "

# execute unit testing
echo "Running unit tests"
java -jar \
    test-lib/junit-platform-console-standalone-1.9.1.jar  \
    --class-path build/test-classes \
    --select-package example.java.gradle.lib
echo " "

# jar
echo "Building Jar..."
jar -cvfm build/main.jar \
    src/main/resources/META-INF/MANIFEST.MF \
    -C build/classes .
echo " "

# debug the content of the jar
echo "Debug jar contents..."
jar tf build/main.jar   
echo " "

# actually run it to make sure it works
echo "Running build/main.jar..."
java -jar build/main.jar  
