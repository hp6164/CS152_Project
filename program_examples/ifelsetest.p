:main () num
{
    num a = 5.
    num b = 3.
    num c = 3.
    num n = 0.
    num temp = 0.
    loop | n leq 4 |
    {
        IF | a - b same c |
        {
            print(c).
        }
        ELSE IF | a - b lt c |
        {
            temp = 0.
            print(temp).
        }
        ELSE
        {
            temp = 99
            print(temp).
        }
        a = a + 1.
        n = n + 1.
    }

    ret 0.
}