module Hello.hello;

import std.stdio;

version (GNU)
{
  class Hail
  {
  public:
    void Print()
      {
        writefln ("Hello, World!");
      }
  }
}
else
{
  void Print()
  {
     writefln ("Hello, World!");
  }
}
