# Get the edge (The deepest projection is the min)
scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner0.CrossProductAxis.xy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_a {Edge:203,StartCorner:5}

scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_a {Edge:202,StartCorner:4}

scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_a {Edge:201,StartCorner:1}

scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_xy/get_edge_a {Edge:200,StartCorner:0}
