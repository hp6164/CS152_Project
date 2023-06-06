:main () num
{
    num i.
    num j. 
    
    i = 0.
    loop | i lt 2 |
    {
        j = 1.
        loop | j leq 3 |
        {
            print(j).
            j = j + 1.
        }
        i = i + 1.
    }

    $ret 0.
}

