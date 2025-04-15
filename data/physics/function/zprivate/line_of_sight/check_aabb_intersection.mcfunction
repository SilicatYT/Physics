# Check if the player's line of sight intersects with the object's AABB
    # Get the ray's origin relative to the object's origin & the ray's direction
    execute if score #Physics.GotRayPos Physics matches 0 run function physics:zprivate/line_of_sight/get_ray

    scoreboard players operation #Physics.RayPosRelative.x Physics = #Physics.RayPosOriginal.x Physics
    scoreboard players operation #Physics.RayPosRelative.y Physics = #Physics.RayPosOriginal.y Physics
    scoreboard players operation #Physics.RayPosRelative.z Physics = #Physics.RayPosOriginal.z Physics

    scoreboard players operation #Physics.RayPosRelative.x Physics -= @s Physics.Object.Pos.x
    scoreboard players operation #Physics.RayPosRelative.y Physics -= @s Physics.Object.Pos.y
    scoreboard players operation #Physics.RayPosRelative.z Physics -= @s Physics.Object.Pos.z

# If the ray hits the AABB (& the distance is less than the current MinDistance, in case another object is in front of that), run the detailed check
# (Important): The relative position is scaled up by 1,000x (So 1,000,000x in total) to provide accuracy when calculating t. Because of this, I use relative coordinates instead of absolute ones, to avoid overflows.
# (Important): The 2nd check for each face explicitly allows for punching the object while facing the backside of a surface.
scoreboard players operation #Physics.RayPosRelative.x Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.RayPosRelative.y Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.RayPosRelative.z Physics *= #Physics.Constants.1000 Physics

    # x axis
    execute if score #Physics.RayPosOriginal.x Physics <= @s Physics.Object.BoundingBoxGlobalMin.x if score #Physics.RayDirectionOriginal.x Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/0 if score #Physics.RayIntersection.t0 Physics < #Physics.MinDistance Physics run return run function physics:zprivate/line_of_sight/check_precise_intersection
    execute if score #Physics.RayPosOriginal.x Physics > @s Physics.Object.BoundingBoxGlobalMin.x if score #Physics.RayDirectionOriginal.x Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/0 if score #Physics.RayIntersection.t0 Physics < #Physics.MinDistance Physics run return run function physics:zprivate/line_of_sight/check_precise_intersection

    execute if score #Physics.RayPosOriginal.x Physics >= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.RayDirectionOriginal.x Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/1 if score #Physics.RayIntersection.t1 Physics < #Physics.MinDistance Physics run return run function physics:zprivate/line_of_sight/check_precise_intersection
    execute if score #Physics.RayPosOriginal.x Physics < @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.RayDirectionOriginal.x Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/1 if score #Physics.RayIntersection.t1 Physics < #Physics.MinDistance Physics run return run function physics:zprivate/line_of_sight/check_precise_intersection

    # y axis
    execute if score #Physics.RayPosOriginal.y Physics <= @s Physics.Object.BoundingBoxGlobalMin.y if score #Physics.RayDirectionOriginal.y Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/2 if score #Physics.RayIntersection.t2 Physics < #Physics.MinDistance Physics run return run function physics:zprivate/line_of_sight/check_precise_intersection
    execute if score #Physics.RayPosOriginal.y Physics > @s Physics.Object.BoundingBoxGlobalMin.y if score #Physics.RayDirectionOriginal.y Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/2 if score #Physics.RayIntersection.t2 Physics < #Physics.MinDistance Physics run return run function physics:zprivate/line_of_sight/check_precise_intersection

    execute if score #Physics.RayPosOriginal.y Physics >= @s Physics.Object.BoundingBoxGlobalMax.y if score #Physics.RayDirectionOriginal.y Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/3 if score #Physics.RayIntersection.t3 Physics < #Physics.MinDistance Physics run return run function physics:zprivate/line_of_sight/check_precise_intersection
    execute if score #Physics.RayPosOriginal.y Physics < @s Physics.Object.BoundingBoxGlobalMax.y if score #Physics.RayDirectionOriginal.y Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/3 if score #Physics.RayIntersection.t3 Physics < #Physics.MinDistance Physics run return run function physics:zprivate/line_of_sight/check_precise_intersection

    # z axis
    execute if score #Physics.RayPosOriginal.z Physics <= @s Physics.Object.BoundingBoxGlobalMin.z if score #Physics.RayDirectionOriginal.z Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/4 if score #Physics.RayIntersection.t4 Physics < #Physics.MinDistance Physics run return run function physics:zprivate/line_of_sight/check_precise_intersection
    execute if score #Physics.RayPosOriginal.z Physics > @s Physics.Object.BoundingBoxGlobalMin.z if score #Physics.RayDirectionOriginal.z Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/4 if score #Physics.RayIntersection.t4 Physics < #Physics.MinDistance Physics run return run function physics:zprivate/line_of_sight/check_precise_intersection

    execute if score #Physics.RayPosOriginal.z Physics >= @s Physics.Object.BoundingBoxGlobalMax.z if score #Physics.RayDirectionOriginal.z Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/5 if score #Physics.RayIntersection.t5 Physics < #Physics.MinDistance Physics run return run function physics:zprivate/line_of_sight/check_precise_intersection
    execute if score #Physics.RayPosOriginal.z Physics < @s Physics.Object.BoundingBoxGlobalMax.z if score #Physics.RayDirectionOriginal.z Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/5 if score #Physics.RayIntersection.t5 Physics < #Physics.MinDistance Physics run function physics:zprivate/line_of_sight/check_precise_intersection
