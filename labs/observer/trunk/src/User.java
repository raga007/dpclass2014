public class User implements Observer {

  private String name;

  @Override
  public void update(String text) {
    System.out.printf("User [%s] received tweet: %s\n", name, text);
  }

  public User(String name) {
    this.name = name;
  }

  public String getName() {
    return name;
  }
}
