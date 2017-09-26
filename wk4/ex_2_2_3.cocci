// Exercise 2.2.3
// Write a semantic patch to remove parentheses in other places where they do not seem to be needed

@@
expression e;
@@
  return
- (
  e
- )
  ;

@@
expression e;
identifier fld;
@@
  &
- (
  e->fld
- )

// EOF
