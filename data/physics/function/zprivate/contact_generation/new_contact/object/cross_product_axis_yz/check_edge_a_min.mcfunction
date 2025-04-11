# Get the edge (The deepest projection is the min)
scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yz/get_edge_a {Edge:27b,StartCorner:3b}

scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yz/get_edge_a {Edge:26b,StartCorner:2b}

scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yz/get_edge_a {Edge:25b,StartCorner:1b}

scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yz/get_edge_a {Edge:24b,StartCorner:0b}
