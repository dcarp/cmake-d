import std.stdio;
import Hello.hello;

int main()
{
  version (GNU)
  {
    Hail hello = new Hail();
    hello.Print();
  }
  else
  {
    Print();
  }
 
  return 0;
}
