# Get the edge (The deepest projection is the max)
scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zz Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner0.CrossProductAxis.zz Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zz/get_edge_a {Edge:28,StartCorner:0}

scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zz/get_edge_a {Edge:29,StartCorner:2}

scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zz/get_edge_a {Edge:30,StartCorner:4}

scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zz/get_edge_a {Edge:31,StartCorner:6}
