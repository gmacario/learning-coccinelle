@@
local idexpression ret;
expression e;
@@

- ret = e;
  return
- ret
+ e
  ;


// BUG: This should only hit when the previous rule is hit!

@@
identifier ret;
type T;
@@

- T ret;
  ... when != ret
