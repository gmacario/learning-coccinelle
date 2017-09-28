// Exercise 2.4.1
//
// The Linux kernel does not normally use typedefs for structure types.
// Write a semantic patch to eliminate typedefs.
// In doing this, it may be necessary to change the structure name.
// Normally, structure names are in lowercase and do not end with _t.
// Note that some typedef’d structures have names of their own and some do not.
// In the former case, it may also be necessary to clean up uses of these names.

@t@
identifier i1;
type t2;
position p;
@@

* typedef struct i1 { ...} t2@p;

@s@
identifier i1;
position p;
@@
 
* struct i1 { ...}@p;

// For examples of python scripting look at
// https://github.com/coccinelle/coccinelle/blob/master/demos/pythontococci.cocci

@script:python@
// t_i1 << t.i1;
// t_t2 << t.t2;
// t_p << t.p;
s_i1 << s.i1;
s_p << s.p;
@@
 
// print "Hello Python"
print coccinelle

// print "DEBUG: t_i1=" + t_i1
// print "DEBUG: t_t2=" + t_t2
// print "DEBUG: len(t_p)", len(t_p)
// for k in range(len(t_p)):
	// print "DEBUG: k=", k
	// print "DEBUG: t_p[", k, "].file=", t_p[k].file
	// print "DEBUG: t_p[", k, "].line=", t_p[k].line

print "DEBUG: s_i1=" + s_i1
print "DEBUG: type(s_p)=", type(s_p);
print "DEBUG: len(s_p)", len(s_p)
// NOTE: s_p is a tuple, but there is only one element in the case of rule s
// (multiple instances only occur in case of "..." where more paths are possible)
for k in range(len(s_p)):
	print "DEBUG: k=", k
	elem = s_p[k];
	print "DEBUG: type(elem)=", type(elem)
	print "DEBUG: type(elem).__name__=", type(elem).__name__
	//
	print "DEBUG: s_p[", k, "].file=", s_p[k].file
	print "DEBUG: s_p[", k, "].line=", s_p[k].line


// EOF
