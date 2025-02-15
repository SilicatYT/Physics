# Get the corner (The deepest projection is the min)
scoreboard players operation #Physics.Projection.OtherObjectCorner0.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner0.ObjectAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_x/get_corner {Corner:7}

scoreboard players operation #Physics.Projection.OtherObjectCorner1.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner1.ObjectAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_x/get_corner {Corner:6}

scoreboard players operation #Physics.Projection.OtherObjectCorner2.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner2.ObjectAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_x/get_corner {Corner:5}

scoreboard players operation #Physics.Projection.OtherObjectCorner3.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner3.ObjectAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_x/get_corner {Corner:4}

scoreboard players operation #Physics.Projection.OtherObjectCorner4.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner4.ObjectAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_x/get_corner {Corner:3}

scoreboard players operation #Physics.Projection.OtherObjectCorner5.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner5.ObjectAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_x/get_corner {Corner:2}

scoreboard players operation #Physics.ProjectionOther.ObjectCorner6.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner6.ObjectAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_x/get_corner {Corner:1}

scoreboard players operation #Physics.Projection.OtherObjectCorner7.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/this_axis_x/get_corner {Corner:0}
