@initialize:ocaml@
@@

let found = ref []

@r@
identifier f;
expression x,e;
@@

x = f(...)
... when != x = e
    when strict
of_node_put(x)

@script:ocaml@
f << r.f;
@@

if not (List.mem f !found)
then
  begin
    found := f :: !found;
    Printf.printf "%s\n" f
  end
