# Get the edge (The deepest projection is the min)
scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.zy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.zy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zy/get_edge_b {Edge:207,StartCorner:3}

scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.zy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.zy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zy/get_edge_b {Edge:206,StartCorner:2}

scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.zy Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis2.zy Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zy/get_edge_b {Edge:205,StartCorner:1}

scoreboard players operation #Physics.Projection.OtherObjectCorner3.CrossProductAxis2.zy Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_zy/get_edge_b {Edge:204,StartCorner:0}
