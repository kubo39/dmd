alias tuple(T...) = T;
alias mytup_t = tuple!(int, float);

void main()
{
    mytup_t tup1;
    assert(tup1 is tup1);
    assert(!(tup1 !is tup1));

    mytup_t tup2;
    assert(tup1 !is tup2);
    assert(!(tup1 is tup2));
}
