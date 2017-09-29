// Exercise 4.5 Finding device node iterator memory leaks

// The device node iterators have the property that each iteration
// gets a node and puts the node obtained on the previous iteration.
// In this way, it is possible to perform an iteration without any get or put.
// However, if the loop aborts, then there will not be a put
// on the last accessed element. Thus, it is necessary to add that put explicitly.
//
// Write a semantic patch to detect such missing of_node_puts in the case
// where the loop is aborted using return. 

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
@@

*i(...,n@p,...)
{
  ... when any
      when != of_node_put(n)
* return ...;
}


// EOF
