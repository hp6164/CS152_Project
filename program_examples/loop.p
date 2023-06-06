:main () num
{

    num i.
    i = 0.
    loop | i lt 10|
    {
        i = i+1.
        print(i).
    }
    
    $ret 0.

    $num n = 0.
    $loop | n leq 4 |
    ${
        $print(n).
    $}
    
}
