# Face 4: Negative z

# Step 1: Calculate t = (boundary_min_z - origin_z) / direction_z
scoreboard players set #Physics.Maths.Value1 Physics -500000
scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.RayPosLocalScaled.z Physics
execute store result score #Physics.RayIntersection.t4 Physics run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.RayDirectionLocal.z Physics

# Step 2: If t is too large, stop. This means no collision with this face is happening.
execute if score #Physics.Maths.Value1 Physics > #Physics.EntityInteractionRange Physics run return 0

# Step 3: Calculate the point of intersection for the other two axes: origin + t * direction
    # x
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionLocal.x Physics
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.RayPosLocalScaled.x Physics
    execute unless score #Physics.Maths.Value1 Physics matches -500000..500000 run return 0

    # y
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.RayIntersection.t4 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionLocal.y Physics
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.RayPosLocalScaled.y Physics

# Update the earliest intersection for the current object
execute if score #Physics.Maths.Value1 Physics matches -500000..500000 if score #Physics.RayIntersection.t4 Physics < #Physics.MinDistance Physics run scoreboard players operation #Physics.MinDistance Physics = #Physics.RayIntersection.t4 Physics
