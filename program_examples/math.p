:main () num
{
    num a = 100.
    num b = 50.
    num c.

    $ Addition, answer is 150, since 100+50 = 150
    c = a+b.
    print(c).

    $Subtraction, answer is 50, since 100-50 = 50
    c = a - b.
    print(c).

    $Multiplication, answer is 500, since 100 * 50 = 500
    c = a*b.
    print(c).

    $Division, answer is 2, since 100/50 = 2
    c = a/b.
    print(c).

    $Modulus, answer is 0, since 100 % 50 = 0
    c = a%b.
    print(c).

    $"Complex" Expression.
    a = 4.
    b = 2.
    c = (a + b) * 7.
    print(c).
    
    ret 0.
}
