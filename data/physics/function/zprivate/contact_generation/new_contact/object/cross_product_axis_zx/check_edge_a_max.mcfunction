# Get the edge (The deepest projection is the max)
scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner0.CrossProductAxis.zx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zx/get_edge_a {Edge:28b,StartCorner:0b}

scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.zx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zx/get_edge_a {Edge:29b,StartCorner:2b}

scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zx/get_edge_a {Edge:30b,StartCorner:4b}

scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zx/get_edge_a {Edge:31b,StartCorner:6b}
