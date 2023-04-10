:main () num
{
    num a = 25.
    num b = 20.
    num c = 2.
    num n = 0.
    loop | n leq 4 |
    {
        IF | a - b same c |
        {
            print(c).
        }
        ELSE
        {
            b = b + 1.
            print(99).
        }
    }

    ret 0.
}