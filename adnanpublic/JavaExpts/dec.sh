javac -cp .:junit.jar AirportScraperInterface.java AirportScraper.java InstrumentedAirportScraper.java DecoratorTest.java
java -cp .:junit.jar org.junit.runner.JUnitCore DecoratorTest
