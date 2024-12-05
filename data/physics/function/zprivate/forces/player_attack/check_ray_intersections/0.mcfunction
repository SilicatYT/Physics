# Surface 1: x=500

# Step 1: Calculate t = (500000-origin_x)/direction_x
scoreboard players set #Physics.Maths.Temp.Value1 Physics.Value 500000
scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value -= #Physics.Maths.RayPosLocalScaled.x Physics.Value
execute store result score #Physics.Maths.RayIntersection.t0 Physics.Value run scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Maths.RayDirectionLocal.x Physics.Value

# Step 2: If t is negative, stop. This means no collision with this face is happening.
execute if score #Physics.Maths.Temp.Value1 Physics.Value matches ..-1 run return run scoreboard players set #Physics.Maths.RayIntersection.t0 Physics.Value 2147483647

# Step 3: Calculate the point of intersection for the other two axes: origin + t * direction
    # y
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.RayDirectionLocal.y Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.RayPosLocalScaled.y Physics.Value
    execute unless score #Physics.Maths.Temp.Value1 Physics.Value matches -500000..500000 run return run scoreboard players set #Physics.Maths.RayIntersection.t0 Physics.Value 2147483647

    # z
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = #Physics.Maths.RayIntersection.t0 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.RayDirectionLocal.z Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.RayPosLocalScaled.z Physics.Value
    execute unless score #Physics.Maths.Temp.Value1 Physics.Value matches -500000..500000 run scoreboard players set #Physics.Maths.RayIntersection.t0 Physics.Value 2147483647
