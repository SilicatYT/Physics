# Get the edge (The deepest projection is the min)
scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yz/get_edge_a {Edge:207,StartCorner:3}

scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yz/get_edge_a {Edge:206,StartCorner:2}

scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yz/get_edge_a {Edge:205,StartCorner:1}

scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yz/get_edge_a {Edge:204,StartCorner:0}
