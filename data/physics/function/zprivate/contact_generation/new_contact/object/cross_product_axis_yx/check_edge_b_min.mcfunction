# Get the edge (The deepest projection is the min)
scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.yx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner0.CrossProductAxis2.yx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yx/get_edge_b {Edge:203,StartCorner:5}

scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.yx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis2.yx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yx/get_edge_b {Edge:202,StartCorner:4}

scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.yx Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis2.yx Physics run return run function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yx/get_edge_b {Edge:201,StartCorner:1}

scoreboard players operation #Physics.Projection.OtherObjectCorner5.CrossProductAxis2.yx Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/cross_product_axis_yx/get_edge_b {Edge:200,StartCorner:0}
