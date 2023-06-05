:main () num
{
    num a.
    num b.
    num c.
    a = 100.
    b = 50.

    IF | a lt b |
    {
       c = b.
    }
    ELSE
    {
       c = a.
    }
    print(c).  $ should print out 100

    $ret 0.
}