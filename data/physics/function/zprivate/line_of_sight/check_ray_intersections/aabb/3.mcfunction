# Face 0: Negative y

# Step 1: Calculate t = (aabb_y_max_relative - origin_y) / direction_y
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.BoundingBoxGlobalMin.y
scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.Pos.y
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.RayPosRelative.y Physics
execute store result score #Physics.RayIntersection.t3 Physics run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.RayDirection.y Physics

# Step 2: If t is negative or too large, stop. This means no collision with this face is happening.
execute if score #Physics.Maths.Value1 Physics matches ..-1 run return 0
execute if score #Physics.Maths.Value1 Physics > #Physics.EntityInteractionRange Physics run return 0

# Step 3: Calculate the point of intersection for the other two axes: origin + t * direction
    # x
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirection.x Physics
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.RayPosRelative.x Physics

    scoreboard players operation #Physics.RelativeAABB.x.Max Physics = @s Physics.Object.BoundingBoxGlobalMax.x
    scoreboard players operation #Physics.RelativeAABB.x.Max Physics -= @s Physics.Object.Pos.x
    scoreboard players operation #Physics.RelativeAABB.x.Max Physics *= #Physics.Constants.1000 Physics
    execute if score #Physics.Maths.Value1 Physics > #Physics.RelativeAABB.x.Max Physics run return 0

    scoreboard players operation #Physics.RelativeAABB.x.Min Physics = @s Physics.Object.BoundingBoxGlobalMin.x
    scoreboard players operation #Physics.RelativeAABB.x.Min Physics -= @s Physics.Object.Pos.x
    scoreboard players operation #Physics.RelativeAABB.x.Min Physics *= #Physics.Constants.1000 Physics
    execute if score #Physics.Maths.Value1 Physics < #Physics.RelativeAABB.x.Min Physics run return 0

    # z
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.RayIntersection.t3 Physics
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
