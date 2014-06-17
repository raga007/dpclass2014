public interface Subject {
  public boolean registerObserver(Observer observer, String track);
  public boolean removeObserver(Observer observer);
  public void notifyObservers(String text);
}
