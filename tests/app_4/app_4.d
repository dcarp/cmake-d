import lib_2.lib_2_import;

// extern(C) int c_func_add_1( int x );

int main()
{
	int x = 1;
	int y;
	y = c_func_add_1(x);
	assert( y == x + 1 );
	return 0;
}
