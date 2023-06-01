:add (num a, num b) num
{
    ret a + b.
}

:mult (num a, num b) num
{
    ret a * b.
}
:main () num
{
    num a.
    num b.
    num c.
    num d.
    a = 100.
    b = 50.
    c = add(a,b).
    print(c).
    d = mult(c, a + b ).
    print(d).
    $ ~~Daniel~~ should not have return statement -- Wed May 31, 5:40pm
    $ret 0.
}
