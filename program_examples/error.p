:main() num
{
    num n.
    list r[ 10 ].
    $list n[ 10 ].
    
    mult().

    scan(n).
    $n = z + 1.
    n = n + r.
    print(n).
}