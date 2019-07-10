enum int sizeof_dptr = (void*).sizeof;
string info_sizeof_dptr = "INFO" ~ ":" ~ "sizeof_dptr[" ~ sizeof_dptr.stringof ~ "]";

int main(string[] args)
{
    int require = 0;
    require += info_sizeof_dptr[args.length];
    return require;
}
