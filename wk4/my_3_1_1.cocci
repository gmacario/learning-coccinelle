@@
bool x;
symbol true, false;
@@

(
  x
- == \(true\|1\)
|
  x
- != \(false\|0\)
|
+ !
  x
- != \(true\|1\)
|
+ !
  x
- == \(false\|0\)
)
