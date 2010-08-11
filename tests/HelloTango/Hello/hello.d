module Hello.hello;

import tango.io.Stdout;

class Hail
{
public:
  void Print()
  {
     Stdout("Hello, World!").newline;
  }
}


