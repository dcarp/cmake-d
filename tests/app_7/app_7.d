import std.stdio;
import core.thread;
import std.perf;

// Yield count should be larger for a 
// more accurate measurment, but this
// is just a unit tests, so don't spin
// for long
immutable uint yield_count = 1000;
immutable uint worker_count = 10;

uint stack_check()
{
	uint x;
	asm
	{
		mov x,ESP;
	}
	return x;
}

void fiber_func()
{
	uint i = yield_count;
	while( --i ) Fiber.yield();
}

void thread_func()
{
	uint i = yield_count;
	while( --i ) Thread.yield();
}

void fiber_test()
{
	Fiber[worker_count] fib_array;

	foreach( ref f; fib_array )
		f = new Fiber( &fiber_func );

	auto timer = new PerformanceCounter;

	uint i = yield_count;

	// fibers are cooperative and need a driver loop
	timer.start();
	bool done;
	do
	{	
		done = true;
		foreach( f; fib_array )
		{
			f.call();
			if( f.state() != f.State.TERM )
				done = false;
		}
	} while( !done );
	timer.stop();

	writeln( "Elapsed time for ", worker_count, " workers times ", yield_count, " yield() calls with fibers = ",
			timer.milliseconds, "ms" );
}

void thread_test()
{
	Thread[worker_count] thread_array;

	foreach( ref t; thread_array )
		t = new Thread( &thread_func );

	auto timer = new PerformanceCounter;
	timer.start();
	foreach( t; thread_array )
		t.start();
	thread_joinAll();
	timer.stop();
	writeln( "Elapsed time for ", worker_count, " workers times ", yield_count, " yield() calls with threads = ",
			timer.milliseconds, "ms" );
}
int main()
{
	fiber_test();
	thread_test();
	return 0;
}
