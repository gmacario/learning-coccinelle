@r@
identifier f;
expression x,e;
@@

x = f(...)
... when != x = e
    when strict
of_node_put(x)

@script:python@
f << r.f;
@@

print f
