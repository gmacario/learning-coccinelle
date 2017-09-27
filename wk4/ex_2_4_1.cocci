// Exercise 2.3.2
//
// The Linux kernel does not normally use typedefs for structure types.
// Write a semantic patch to eliminate typedefs.
// In doing this, it may be necessary to change the structure name.
// Normally, structure names are in lowercase and do not end with _t.
// Note that some typedef’d structures have names of their own and some do not.
// In the former case, it may also be necessary to clean up uses of these names.

@@
identifier i1;
type i2;
@@

* typedef struct i1 { ...} i2;


// EOF
