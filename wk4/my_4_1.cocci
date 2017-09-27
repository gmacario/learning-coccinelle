// Exercise 4.1 Finding the relevant functions

//The key point we are going to look into with respect to device nodes is memory management. Device nodes are reference counted, so the main relevant functions are x = of_node_get(y); (increment the reference count of y and return a pointer to the result which is stored in x) and of_node_put(x); (decrement the reference counter of x and possibly free it). of_node_get(), however, is not that common. More commonly, some kind of search function is called that finds a node with a particular property and return a pointer to it. The goal of this exercise is to collect the names of these functions. To this end, write a semantic patch that prints the name of any function such that the returned value is ultimately passed to of_node_put.

@r@
identifier f;
expression x,e;
position p1, p2;
@@

x = f(...)@p1
... when != x = e
    when strict
of_node_put(x)@p2

@script:python@
f << r.f;
p1 << r.p1;
p2 << r.p2;
@@

print "DEBUG: f=", f
print "DEBUG: p1: file", p1[0].file, ", line=", p1[0].line
print "DEBUG: p2: file", p2[0].file, ", line=", p2[0].line

// EOF
