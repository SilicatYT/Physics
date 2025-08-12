# Get the corner (The deepest projection is the min)
scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.z Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner0.OtherObjectAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_z/get_corner {Corner:7b}

scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.z Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner1.OtherObjectAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_z/get_corner {Corner:6b}

scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.z Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner2.OtherObjectAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_z/get_corner {Corner:5b}

scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.z Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner3.OtherObjectAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_z/get_corner {Corner:4b}

scoreboard players operation #Physics.Projection.ObjectCorner4.OtherObjectAxis.z Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner4.OtherObjectAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_z/get_corner {Corner:3b}

scoreboard players operation #Physics.Projection.ObjectCorner5.OtherObjectAxis.z Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner5.OtherObjectAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_z/get_corner {Corner:2b}

scoreboard players operation #Physics.Projection.ObjectCorner6.OtherObjectAxis.z Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner6.OtherObjectAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_z/get_corner {Corner:1b}

scoreboard players operation #Physics.Projection.ObjectCorner7.OtherObjectAxis.z Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/other_axis_z/get_corner {Corner:0b}
