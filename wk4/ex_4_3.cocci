@fns@
identifier i;
@@

(
of_cpu_device_node_get@i(...)
|
of_find_compatible_node@i(...)
|
of_find_matching_node@i(...)
|
of_find_next_cache_node@i(...)
|
of_find_node_by_name@i(...)
|
of_find_node_by_path@i(...)
|
of_find_node_by_phandle@i(...)
|
of_find_node_by_type@i(...)
|
of_find_node_opts_by_path@i(...)
|
of_find_node_with_property@i(...)
|
of_get_child_by_name@i(...)
|
of_get_cpu_node@i(...)
|
of_get_next_available_child@i(...)
|
of_get_next_child@i(...)
|
of_get_parent@i(...)
|
of_graph_get_next_endpoint@i(...)
|
of_graph_get_port_parent@i(...)
|
of_graph_get_remote_endpoint@i(...)
|
of_graph_get_remote_node@i(...)
|
of_graph_get_remote_port@i(...)
|
of_graph_get_remote_port_parent@i(...)
|
of_node_get@i(...)
|
of_parse_phandle@i(...)
)

@r@
position p;
identifier fns.i;
local idexpression x;
@@

x@p = i(...)
...
of_node_put(x)

@s@
position r.p;
identifier fns.i;
local idexpression x;
expression e;
statement S;
@@

x@p = i(...);
if (x == NULL) S
... when != of_node_put(x)
    when != e = x
    when != return x;

@depends on s@
position r.p;
identifier fns.i;
local idexpression x;
expression e;
statement S;
@@

*x@p = i(...);
if (x == NULL) S
... when != of_node_put(x)
    when != e = x
(
return x;
|
*return ...;
)

