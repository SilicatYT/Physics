# Get the edge (The deepest projection is the max)
scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yy/get_edge_a {Edge:24b,StartCorner:0b}

scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yy/get_edge_a {Edge:25b,StartCorner:1b}

scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yy/get_edge_a {Edge:26b,StartCorner:2b}

scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yy/get_edge_a {Edge:27b,StartCorner:3b}
