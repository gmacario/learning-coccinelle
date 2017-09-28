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
then found := f :: !found

@finalize:ocaml@
founds << merge.found;
@@

List.iter
    (fun f ->
      List.iter
        (fun x -> if not (List.mem x !found) then found := x :: !found)
        !f)
    founds;
List.iter (fun x -> Printf.printf "%s\n" x) !found
