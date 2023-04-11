:main () num
{
    num n = 1.
    loop | n geq 0 |
    {
        print(n).
	IF | n same 8 |
        {
            break.
        }
    }

    ret 0.
}
