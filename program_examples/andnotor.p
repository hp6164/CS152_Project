:main () num
{
    num zero = 0.
    num two = 2.
    num yes = 999.
    num no = 111.

$should display 999
    IF | two gt zero |
    {
        print(yes).
    }
    ELSE
    {
        print(no).
    }

$should print 111
    IF | NOT two gt zero | 
    {
        print(yes).
    }
    ELSE
    {
        print(no).
    }

$ calculates the max of three integers
    num a.
    num b.
    num c.
    num max.

    scan(a). scan(b). scan(c).
    max = a.

    IF | a gt b |
    {
        IF | a gt c |
        {
            max = a.
        }
        ELSE 
        {
            max = c.
        }
    }
    ELSE
    {
        IF | b gt c |
        {
            max = b.
        }
        ELSE 
        {
            max = c. 
        }
    }

    printL(max).

    $ret 0.
}