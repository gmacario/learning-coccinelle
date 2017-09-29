// Fix dereferencing a NULL pointer
// See https://lwn.net/Articles/315686/

@@
expression E;
identifier fld;
@@

- !E && !E->fld
+ !E || !E->fld
