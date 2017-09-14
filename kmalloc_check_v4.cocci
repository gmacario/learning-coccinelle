// See tutorial.pdf, Slide 59

@@ expression e, e1; identifier f; @@
  e = kmalloc(...);
  ... when != e = e1
(
      e == NULL || ...
|
      e != NULL || ...
|
* e->f
)
