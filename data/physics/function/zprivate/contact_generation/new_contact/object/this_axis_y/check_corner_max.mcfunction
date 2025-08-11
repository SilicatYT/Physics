# Get the corner (The deepest projection is the max)
scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.y Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner0.ObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_y/get_corner {Corner:0}

scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.y Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner1.ObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_y/get_corner {Corner:1}

scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.y Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner2.ObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_y/get_corner {Corner:2}

scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.y Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner3.ObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_y/get_corner {Corner:3}

scoreboard players operation #Physics.Projection.OtherObjectCorner4.ObjectAxis.y Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner4.ObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_y/get_corner {Corner:4}

scoreboard players operation #Physics.Projection.OtherObjectCorner5.ObjectAxis.y Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner5.ObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_y/get_corner {Corner:5}

scoreboard players operation #Physics.Projection.OtherObjectCorner6.ObjectAxis.y Physics /= #Physics.Constants.1000 Physics
execute if score #Physics.DeepestProjection Physics = #Physics.Projection.OtherObjectCorner6.ObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis_y/get_corner {Corner:6}

scoreboard players operation #Physics.Projection.OtherObjectCorner7.ObjectAxis.y Physics /= #Physics.Constants.1000 Physics
function physics:zprivate/contact_generation/new_contact/object/this_axis_y/get_corner {Corner:7}
