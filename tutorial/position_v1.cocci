// Positions and Python
// See tutorial.pdf Slide 66

@r@
expression e,e1;
identifier f;
position p1, p2;
@@
  e = kmalloc@p1(...);
  ... when != e = e1
(
  e == NULL || ...
|
  e != NULL && ...
|
  e@p2->f
)

@script:python@
p1 << r.p1;
p2 << r.p2;
@@
l1 = p1[0].line
l2 = p2[0].line
print "kmalloc on line %s not tested before reference on line %s" % (l1,l2)
