extern(C) int cfunc( int x );
int main()
{
	int x = 1;
	int y;
	y = cfunc(x);
	assert( y == x + 1 );
	return 0;
}
