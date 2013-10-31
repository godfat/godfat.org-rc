
public class Bad{
  public static void main(String[] args){
    String[] a = new String[1];
    Object[] b = a;
    b[0] = 1;
    System.out.println(b[0]);
  }
}

