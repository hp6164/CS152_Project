:main() num
{
    num a = 0.
    num b = 0.

    loop | a lt 4 |
    {
        IF | a same 3 |
        {
            break.
        }
        print(a).
        a = a + 1.
        contn.
    }
    print(b).
    print(a).
    
}