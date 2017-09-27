// Exercise 2.4 - Step 3
//
// The Linux kernel does not normally use typedefs for structure types.
// Write a semantic patch to eliminate typedefs.
// In doing this, it may be necessary to change the structure name.
// Normally, structure names are in lowercase and do not end with _t.
// Note that some typedef’d structures have names of their own and some do not.
// In the former case, it may also be necessary to clean up uses of these names.


@r@
identifier i1;
type i2;
@@

typedef struct i1 { ... } i2;

@script:python s@
i2 << r.i2;
nm;
@@

i2 = i2.lower()
print "DEBUG: s: i2=", i2
len = len(i2)

// Remove trailing "_t" if any
if (len > 2 and i2.endswith("_t")):
	i2 = i2[0:len-2]

// Python equivalent of OCaml
// nm := make_ident i2
//
// Option 1
coccinelle.nm = cocci.make_ident(i2)
//
// Option 2
// coccinelle.nm = i2

@@
identifier r.i1,s.nm;
type r.i2;
@@

- typedef
    struct
- i1
+ nm
   { ... }
- i2
  ;

@@
identifier r.i1,s.nm;
@@

struct
- i1
+ nm

@@
identifier s.nm;
type r.i2;
@@

- i2
+ struct nm

// EOF
