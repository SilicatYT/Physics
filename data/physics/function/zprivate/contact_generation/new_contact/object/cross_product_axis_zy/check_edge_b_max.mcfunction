# Get the edge (The deepest projection is the max)
scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zy/get_edge_b {Edge:24b,StartCorner:0b}

scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zy/get_edge_b {Edge:25b,StartCorner:1b}

scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.zy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis.zy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zy/get_edge_b {Edge:26b,StartCorner:2b}

scoreboard players operation #Physics.Projection.OtherObjectCorner3.CrossProductAxis.zy Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zy/get_edge_b {Edge:27b,StartCorner:3b}
