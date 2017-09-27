// Exercise 3.1.2
//
// Some operators such as < and > already have boolean return type,
// so there is not need to convert their results to booleans.
// An example of such an unnecessary test is:
// value > 3900 ? true : false
// Write a semantic patch to drop these unnecessary tests.
// Note that the transformation may require negating the test expression,
// depending on the order of the true and false values.

// TODO: what does "(ONCE) Expected tokens true false" warning mean?

@@
binary operator op = {<, <=, >=, >};
expression e1, e2;
symbol true, false;
@@

 (e1 op e2)
- ? true : false

@@
binary operator op = {<, <=, >=, >};
expression e1, e2;
symbol true, false;
@@

+ !(
  e1 op e2
+ )
- ? false : true

@@
binary operator op = {<, <=, >=, >};
expression e1, e2;
symbol true, false;
@@

+ !
  (e1 op e2)
- ? false: true

// EOF
