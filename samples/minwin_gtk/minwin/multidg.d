/* MultiDelegate: add, remove and fire multiple delegates
 *
 * A multi-delegate is similar to a C# multicast delegate.
 * It has array copy semantics so assignment will copy the
 * length and data pointer but modification could allocate
 * a distinct copy. Delegates in a multi-delegate are fired
 * in the order they were added.
 *
 * A MultiBoolDelegate is a multi-delegates where each
 * delegate returns a bool and the result of executing
 * the MultiBoolDelegate is the or'ed value of all the bools.
 *
 * To append to a multi-delegate use ~=
 * To remove a delegate from a multi-delegate use remove()
 * To fire all the delegates in order use opCall: multidg()
 * To test if the multi-delegate is empty use isEmpty()
 *
 * Written by Ben Hinkle and released to the public domain, as
 * explained at http://creativecommons.org/licenses/publicdomain
 * Report comments and bugs at dsource: http://www.dsource.org/projects/minwin
 */

module minwin.multidg;

template DelegateMixin() {

    // Append dg to the end of the multi-delegate.
    // If dg is null nothing changes.
    void opCatAssign(Callback dg) {
        if (dg is null) return;
        bool found = false;
        int len = dgs.length;
        int n = len-1;
        while (n >= 0 && dgs[n] is null)
            --n;
        if (n < len-1)
            dgs[n+1] = dg;
        else
            dgs ~= dg;
    }

    // Remove the first occurance of dg from the multi-delegate.
    // If dg is not in the multi-delegate nothing changes.
    void remove(Callback dg) {
        if (dgs.length == 0) return;
        bool found = false;
        for (int n=0 ; n < dgs.length-1; ++n) {
            if (!found && dgs[n] is dg) found = true;
            if (found) dgs[n] = dgs[n+1];
            if (dgs[n] is null) break;
        }
        if (found || dgs[length-1] is dg)
            dgs[length-1] = null;
    }

    bool isEmpty() {
        if (dgs.length == 0)
            return true;
        else if (dgs[0] is null)
            return true;
        else
            return false;
    }

    // the array of delegate with possible trailing nulls
    Callback[] dgs;
}

// MultiDelegate with variadic args
struct MultiDelegate(T...)
{
    alias void delegate(T) Callback;
    mixin DelegateMixin!();
    void opCall(T args) {
        foreach( Callback dg; dgs) {
            if (dg is null) break;
            dg(args);
        }
    }
}

// MultiBoolDelegate with variadic args
struct MultiBoolDelegate(T...) {
    alias bool delegate(T) Callback;
    mixin DelegateMixin!();
    bool opCall(T args) {
        bool result = false;
        foreach( Callback dg; dgs) {
            if (dg is null) break;
            result |= dg(args);
        }
        return result;
    }
}

unittest {
    /** Example class illustrating multi-delegates based on Qt's example at
     *        http://doc.trolltech.com/3.3/signalsandslots.html
     *
     */
    class Foo {
        MultiDelegate!(int) valueChanged;
        private int val;
        int value() {
            return val;
        }
        void value(int v) {
            if (val != v) {
                val = v;
                valueChanged(v);
            }
        }
        MultiBoolDelegate!(int,double) boolDelegate;
        private int val2;
        int value2() {
            return val2;
        }
        void value2(int v) {
            if (val2 != v && !boolDelegate(v,2.0*v)) {
                val2 = v;
            }
        }
    }

    Foo a = new Foo;
    Foo b = new Foo;
    Foo c = new Foo;
    a.valueChanged ~= &b.value;
    assert( a.value == 0 );
    assert( b.value == 0 );
    b.value = 11;
    assert( a.value == 0 );
    assert( b.value == 11 );
    a.value = 79;
    assert( a.value == 79 );
    assert( b.value == 79 );
    a.valueChanged ~= &c.value;
    a.value = 80;
    assert( a.value == 80 );
    assert( b.value == 80 );
    assert( c.value == 80 );
    a.valueChanged.remove(&b.value);
    a.value = 100;
    assert( a.value == 100 );
    assert( b.value == 80 );
    assert( c.value == 100 );

    a.boolDelegate ~= delegate bool(int x,double y) {
        return (y > 10.0);
    };
    a.value2 = 2;
    assert( a.value2 == 2 );
    a.value2 = 20;
    assert( a.value2 == 2 );
}
