# Get the edge (The deepest projection is the min)
scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xz Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner0.CrossProductAxis.xz Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xz/get_edge_a {Edge:23,StartCorner:5}

scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xz Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.xz Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xz/get_edge_a {Edge:22,StartCorner:4}

scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xz/get_edge_a {Edge:21,StartCorner:1}

scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.xz Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xz/get_edge_a {Edge:20,StartCorner:0}
