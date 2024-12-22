# Surface 1: x=500

# Step 1: Calculate t = (500000-origin_x)/direction_x
scoreboard players set #Physics.Maths.Value1 Physics 500000
scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.RayPosLocalScaled.x Physics
execute store result score #Physics.Maths.RayIntersection.t0 Physics run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Maths.RayDirectionLocal.x Physics

# Step 2: If t is negative, stop. This means no collision with this face is happening.
execute if score #Physics.Maths.Value1 Physics matches ..-1 run return run scoreboard players set #Physics.Maths.RayIntersection.t0 Physics 2147483647

# Step 3: Calculate the point of intersection for the other two axes: origin + t * direction
    # y
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayDirectionLocal.y Physics
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.RayPosLocalScaled.y Physics
    execute unless score #Physics.Maths.Value1 Physics matches -500000..500000 run return run scoreboard players set #Physics.Maths.RayIntersection.t0 Physics 2147483647

    # z
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Maths.RayIntersection.t0 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.RayDirectionLocal.z Physics
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.RayPosLocalScaled.z Physics
    execute unless score #Physics.Maths.Value1 Physics matches -500000..500000 run scoreboard players set #Physics.Maths.RayIntersection.t0 Physics 2147483647
