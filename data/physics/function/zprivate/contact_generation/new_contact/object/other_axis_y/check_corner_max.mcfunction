# Get the corner (The deepest projection is the max)
scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.y Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner0.OtherObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_y/get_corner {Corner:0b}

scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.y Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner1.OtherObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_y/get_corner {Corner:1b}

scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.y Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner2.OtherObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_y/get_corner {Corner:2b}

scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.y Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner3.OtherObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_y/get_corner {Corner:3b}

scoreboard players operation #Physics.Projection.ObjectCorner4.OtherObjectAxis.y Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner4.OtherObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_y/get_corner {Corner:4b}

scoreboard players operation #Physics.Projection.ObjectCorner5.OtherObjectAxis.y Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner5.OtherObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_y/get_corner {Corner:5b}

scoreboard players operation #Physics.Projection.ObjectCorner6.OtherObjectAxis.y Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner6.OtherObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis_y/get_corner {Corner:6b}

scoreboard players operation #Physics.Projection.ObjectCorner7.OtherObjectAxis.y Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/other_axis_y/get_corner {Corner:7b}
