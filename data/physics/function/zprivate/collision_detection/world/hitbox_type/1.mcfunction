# HitboxType 1 (Solid)

# Get how much each axis is overlapping & get the least overlap
# (Important): If two axes are exactly parallel to each other (Like if the objects are resting ontop of each other), their cross product is [0,0,0]. I'm unsure if discarding cross products with an overlap of 0 or with a value of [0,0,0] is more stable, so I'll revisit it once the resolver is done. For now, I discard cross products with an overlap of 0.
    # x_block
    scoreboard players operation #Physics.Overlap.WorldAxis.x Physics = @s Physics.Object.BoundingBoxGlobalMax.x
    scoreboard players operation #Physics.Overlap.WorldAxis.x Physics -= #Physics.Projection.Block.WorldAxis.x.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.WorldAxis.x.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.BoundingBoxGlobalMin.x
    execute if score #Physics.Overlap.WorldAxis.x Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.WorldAxis.x Physics = #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.x Physics

    # y_block
    scoreboard players operation #Physics.Overlap.WorldAxis.y Physics = @s Physics.Object.BoundingBoxGlobalMax.y
    scoreboard players operation #Physics.Overlap.WorldAxis.y Physics -= #Physics.Projection.Block.WorldAxis.y.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.WorldAxis.y.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.BoundingBoxGlobalMin.y
    execute if score #Physics.Overlap.WorldAxis.y Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.WorldAxis.y Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.WorldAxis.y Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.y Physics

    # z_block
    scoreboard players operation #Physics.Overlap.WorldAxis.z Physics = @s Physics.Object.BoundingBoxGlobalMax.z
    scoreboard players operation #Physics.Overlap.WorldAxis.z Physics -= #Physics.Projection.Block.WorldAxis.z.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.WorldAxis.z.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.BoundingBoxGlobalMin.z
    execute if score #Physics.Overlap.WorldAxis.z Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.WorldAxis.z Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.WorldAxis.z Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.z Physics

    # x_object
    scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics = @s Physics.Object.ProjectionOwnAxis.x.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics -= #Physics.Projection.Block.ObjectAxis.x.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.ObjectAxis.x.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.ProjectionOwnAxis.x.Min
    execute if score #Physics.Overlap.ObjectAxis.x Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.ObjectAxis.x Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.x Physics

    # y_object
    scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics = @s Physics.Object.ProjectionOwnAxis.y.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics -= #Physics.Projection.Block.ObjectAxis.y.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.ObjectAxis.y.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.ProjectionOwnAxis.y.Min
    execute if score #Physics.Overlap.ObjectAxis.y Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.ObjectAxis.y Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.y Physics

    # z_object
    scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics = @s Physics.Object.ProjectionOwnAxis.z.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics -= #Physics.Projection.Block.ObjectAxis.z.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.ObjectAxis.z.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.ProjectionOwnAxis.z.Min
    execute if score #Physics.Overlap.ObjectAxis.z Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.ObjectAxis.z Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.z Physics

    # Cross product: x_block x x_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xx Physics = #Physics.Projection.Object.CrossProductAxis.xx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xx Physics -= #Physics.Projection.Block.CrossProductAxis.xx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.xx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.xx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.xx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.xx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.xx Physics unless score #Physics.Overlap.CrossProductAxis.xx Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xx Physics

    # Cross product: x_block x y_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xy Physics = #Physics.Projection.Object.CrossProductAxis.xy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xy Physics -= #Physics.Projection.Block.CrossProductAxis.xy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.xy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.xy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.xy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.xy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.xy Physics unless score #Physics.Overlap.CrossProductAxis.xy Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xy Physics

    # Cross product: x_block x z_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xz Physics = #Physics.Projection.Object.CrossProductAxis.xz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xz Physics -= #Physics.Projection.Block.CrossProductAxis.xz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.xz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.xz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.xz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.xz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.xz Physics unless score #Physics.Overlap.CrossProductAxis.xz Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xz Physics

    # Cross product: y_block x x_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yx Physics = #Physics.Projection.Object.CrossProductAxis.yx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yx Physics -= #Physics.Projection.Block.CrossProductAxis.yx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.yx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.yx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.yx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.yx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.yx Physics unless score #Physics.Overlap.CrossProductAxis.yx Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yx Physics

    # Cross product: y_block x y_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yy Physics = #Physics.Projection.Object.CrossProductAxis.yy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yy Physics -= #Physics.Projection.Block.CrossProductAxis.yy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.yy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.yy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.yy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.yy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.yy Physics unless score #Physics.Overlap.CrossProductAxis.yy Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yy Physics

    # Cross product: y_block x z_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yz Physics = #Physics.Projection.Object.CrossProductAxis.yz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yz Physics -= #Physics.Projection.Block.CrossProductAxis.yz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.yz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.yz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.yz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.yz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.yz Physics unless score #Physics.Overlap.CrossProductAxis.yz Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yz Physics

    # Cross product: z_block x x_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zx Physics = #Physics.Projection.Object.CrossProductAxis.zx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zx Physics -= #Physics.Projection.Block.CrossProductAxis.zx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.zx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.zx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.zx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.zx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.zx Physics unless score #Physics.Overlap.CrossProductAxis.zx Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.zx Physics

    # Cross product: z_block x y_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zy Physics = #Physics.Projection.Object.CrossProductAxis.zy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zy Physics -= #Physics.Projection.Block.CrossProductAxis.zy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.zy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.zy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.zy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.zy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.zy Physics unless score #Physics.Overlap.CrossProductAxis.zy Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.zy Physics

    # Cross product: z_block x z_object
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zz Physics = #Physics.Projection.Object.CrossProductAxis.zz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zz Physics -= #Physics.Projection.Block.CrossProductAxis.zz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.Block.CrossProductAxis.zz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.zz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.zz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.zz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.zz Physics unless score #Physics.Overlap.CrossProductAxis.zz Physics matches 0 run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_zz/main

# Get the involved features of both objects
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/world/world_axis_x/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/world/world_axis_y/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.WorldAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/world/world_axis_z/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/world/object_axis_x/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/world/object_axis_y/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/world/object_axis_z/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xx Physics run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xx/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xy Physics run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xy/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xz Physics run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_xz/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yx Physics run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_yx/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yy Physics run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_yy/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yz Physics run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_yz/main
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.zx Physics run return run function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_zx/main
function physics:zprivate/contact_generation/new_contact/world/cross_product_axis_zy/main
