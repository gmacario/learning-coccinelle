// Exercise 4.6 Finding device node iterator double frees

// Continuing from the previous exercise, an `of_node_put`
// on the index variable of a device node iterator with
// no previous `of_node_get` on that variable and with
// no subsequent jump out of the loop amounts to a double free.
// Write a semantic patch to detect such calls to of_node_put.

@start@
expression e,n;
position p;
statement S;
iterator name
for_each_available_child_of_node,
__for_each_child_of_node,
for_each_child_of_node,
for_each_compatible_node,
for_each_endpoint_of_node,
for_each_matching_node,
for_each_matching_node_and_match,
for_each_node_by_name,
for_each_node_by_type,
for_each_node_with_property,
for_each_of_allnodes,
for_each_of_allnodes_from,
for_each_property_of_node;
@@

(
for_each_available_child_of_node(e,n@p,...) S
|
__for_each_child_of_node(e,n@p,...) S
|
for_each_child_of_node(e,n@p,...) S
|
for_each_compatible_node(n@p,...) S
|
for_each_endpoint_of_node(e,n@p,...) S
|
for_each_matching_node(n@p,...) S
|
for_each_matching_node_and_match(n@p,...) S
|
for_each_node_by_name(n@p,...) S
|
for_each_node_by_type(n@p,...) S
|
for_each_node_with_property(n@p,...) S
|
for_each_of_allnodes(n@p,...) S
|
for_each_of_allnodes_from(e,n@p,...) S
|
for_each_property_of_node(n@p,...) S
)


@@
iterator i;
position start.p;
expression n;
identifier l;
@@

*i(...,n@p,...)
{
  ... when any
      when != of_node_get(n)
* of_node_put(n);
//  ... when = \(break;\|goto l;\|return ...;\)
  ...
  break;
}


// EOF
