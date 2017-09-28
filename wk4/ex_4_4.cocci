@fromparam@
identifier f,x;
iterator i;
position p;
statement S;
@@

f(...,struct device_node *x,...) {
  <...
  i(...,x@p,...) S
  ...>
}

@r exists@
local idexpression struct device_node *n;
iterator i,i1;
statement S,S1;
expression e;
expression list[len] es;
position p != fromparam.p;
@@

... when != n = e
    when != i1(...,n,...) S1
i(es,n@p,...)
 S

@script:python@
len << r.len;
i << r.i;
@@

print i,len
