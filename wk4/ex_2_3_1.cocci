// Exercise 2.3.1

@@
expression e;
constant char [] c;
identifier print;
statement S;
@@

  e = \(kmalloc\|kzalloc\|kcalloc\|devm_kmalloc\|devm_kcalloc\)(...);
  if (e == NULL)
- {
  print(c);
  S
- }

@@
expression e;
constant char [] c;
identifier print;
@@

  e = \(kmalloc\|kzalloc\|kcalloc\|devm_kmalloc\|devm_kcalloc\)(...);
  if (e == NULL) {
    ...
    print(c);
    ...
  }
