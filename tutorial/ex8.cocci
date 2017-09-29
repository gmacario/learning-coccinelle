// See tutorial.pdf, Slide 60

@@
expression e,e1;
identifier id;
@@

- e = kmalloc(e1, id)
+ e = kzalloc(e1, id)
... when != e != NULL

- memset(e, 0, sizeof(*e));
