rm -f TestBinaryTreeCanonical.class BinaryTreeCanonical.class
javac -cp junit-4.10.jar:. TestBinaryTreeCanonical.java BinaryTreeCanonical.java
java -cp junit-4.10.jar:. org.junit.runner.JUnitCore TestBinaryTreeCanonical
result=$?
echo "result is " $result
