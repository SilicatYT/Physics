# Get the edge (The deepest projection is the min)
scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis2.zy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner0.CrossProductAxis2.zy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zy/get_edge_a {Edge:211,StartCorner:6}

scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis2.zy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis2.zy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zy/get_edge_a {Edge:210,StartCorner:4}

scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis2.zy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis2.zy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zy/get_edge_a {Edge:209,StartCorner:2}

scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis2.zy Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zy/get_edge_a {Edge:208,StartCorner:0}
