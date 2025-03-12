# Get the edge (The deepest projection is the min)
scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yy/get_edge_a {Edge:27,StartCorner:3}

scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yy/get_edge_a {Edge:26,StartCorner:2}

scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yy/get_edge_a {Edge:25,StartCorner:1}

scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yy/get_edge_a {Edge:24,StartCorner:0}
