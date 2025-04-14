# Face 1: Negative x

# Step 1: Calculate t = (aabb_x_max_relative - origin_x) / direction_x
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.BoundingBoxGlobalMin.x
scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.Pos.x
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.RayPosRelative.x Physics
execute store result score #Physics.RayIntersection.t1 Physics run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.RayDirection.x Physics

# Step 2: If t is negative or too large, stop. This means no collision with this face is happening.
execute if score #Physics.Maths.Value1 Physics matches ..-1 run return 0
execute if score #Physics.Maths.Value1 Physics > #Physics.EntityInteractionRange Physics run return 0

# Step 3: Calculate the point of intersection for the other two axes: origin + t * direction
    # y
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirection.y Physics
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.RayPosRelative.y Physics

    scoreboard players operation #Physics.RelativeAABB.y.Max Physics = @s Physics.Object.BoundingBoxGlobalMax.y
    scoreboard players operation #Physics.RelativeAABB.y.Max Physics -= @s Physics.Object.Pos.y
    scoreboard players operation #Physics.RelativeAABB.y.Max Physics *= #Physics.Constants.1000 Physics
    execute if score #Physics.Maths.Value1 Physics > #Physics.RelativeAABB.y.Max Physics run return 0

    scoreboard players operation #Physics.RelativeAABB.y.Min Physics = @s Physics.Object.BoundingBoxGlobalMin.y
    scoreboard players operation #Physics.RelativeAABB.y.Min Physics -= @s Physics.Object.Pos.y
    scoreboard players operation #Physics.RelativeAABB.y.Min Physics *= #Physics.Constants.1000 Physics
    execute if score #Physics.Maths.Value1 Physics < #Physics.RelativeAABB.y.Min Physics run return 0

    # z
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.RayIntersection.t1 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirection.z Physics
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.RayPosRelative.z Physics

    scoreboard players operation #Physics.RelativeAABB.z.Max Physics = @s Physics.Object.BoundingBoxGlobalMax.z
    scoreboard players operation #Physics.RelativeAABB.z.Max Physics -= @s Physics.Object.Pos.z
    scoreboard players operation #Physics.RelativeAABB.z.Max Physics *= #Physics.Constants.1000 Physics
    execute if score #Physics.Maths.Value1 Physics > #Physics.RelativeAABB.z.Max Physics run return 0

    scoreboard players operation #Physics.RelativeAABB.z.Min Physics = @s Physics.Object.BoundingBoxGlobalMin.z
    scoreboard players operation #Physics.RelativeAABB.z.Min Physics -= @s Physics.Object.Pos.z
    scoreboard players operation #Physics.RelativeAABB.z.Min Physics *= #Physics.Constants.1000 Physics
    execute if score #Physics.Maths.Value1 Physics < #Physics.RelativeAABB.z.Min Physics run return 0

return 1
