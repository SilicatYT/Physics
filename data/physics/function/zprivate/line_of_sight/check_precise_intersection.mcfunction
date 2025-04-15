# Transform the relative ray origin to the object's local coordinate system by applying the transpose of the rotation matrix (Transpose because I convert from world to local coordinates)
# (Important): Because of the multiplication, I need to divide the result by 1,000 to keep the 1,000x scaling. But I divide by the object's dimensions afterwards, which does the job too. Same applies for the ray direction.
scoreboard players operation #Physics.RayPosRelative.x Physics /= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.RayPosRelative.y Physics /= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.RayPosRelative.z Physics /= #Physics.Constants.1000 Physics

scoreboard players operation #Physics.RayPosLocal.x Physics = @s Physics.Object.RotationMatrixTranspose.0
scoreboard players operation #Physics.RayPosLocal.x Physics *= #Physics.RayPosRelative.x Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.1
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayPosRelative.y Physics
scoreboard players operation #Physics.RayPosLocal.x Physics += #Physics.Maths.Value1 Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.2
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayPosRelative.z Physics
scoreboard players operation #Physics.RayPosLocal.x Physics += #Physics.Maths.Value1 Physics

scoreboard players operation #Physics.RayPosLocal.y Physics = @s Physics.Object.RotationMatrixTranspose.3
scoreboard players operation #Physics.RayPosLocal.y Physics *= #Physics.RayPosRelative.x Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.4
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayPosRelative.y Physics
scoreboard players operation #Physics.RayPosLocal.y Physics += #Physics.Maths.Value1 Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.5
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayPosRelative.z Physics
scoreboard players operation #Physics.RayPosLocal.y Physics += #Physics.Maths.Value1 Physics

scoreboard players operation #Physics.RayPosLocal.z Physics = @s Physics.Object.RotationMatrixTranspose.6
scoreboard players operation #Physics.RayPosLocal.z Physics *= #Physics.RayPosRelative.x Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.7
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayPosRelative.y Physics
scoreboard players operation #Physics.RayPosLocal.z Physics += #Physics.Maths.Value1 Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.8
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayPosRelative.z Physics
scoreboard players operation #Physics.RayPosLocal.z Physics += #Physics.Maths.Value1 Physics

# Transform the ray direction to the object's local coordinate system
scoreboard players operation #Physics.RayDirectionLocal.x Physics = @s Physics.Object.RotationMatrixTranspose.0
scoreboard players operation #Physics.RayDirectionLocal.x Physics *= #Physics.RayDirectionOriginal.x Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.1
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionOriginal.y Physics
scoreboard players operation #Physics.RayDirectionLocal.x Physics += #Physics.Maths.Value1 Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.2
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionOriginal.z Physics
scoreboard players operation #Physics.RayDirectionLocal.x Physics += #Physics.Maths.Value1 Physics

scoreboard players operation #Physics.RayDirectionLocal.y Physics = @s Physics.Object.RotationMatrixTranspose.3
scoreboard players operation #Physics.RayDirectionLocal.y Physics *= #Physics.RayDirectionOriginal.x Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.4
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionOriginal.y Physics
scoreboard players operation #Physics.RayDirectionLocal.y Physics += #Physics.Maths.Value1 Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.5
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionOriginal.z Physics
scoreboard players operation #Physics.RayDirectionLocal.y Physics += #Physics.Maths.Value1 Physics

scoreboard players operation #Physics.RayDirectionLocal.z Physics = @s Physics.Object.RotationMatrixTranspose.6
scoreboard players operation #Physics.RayDirectionLocal.z Physics *= #Physics.RayDirectionOriginal.x Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.7
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionOriginal.y Physics
scoreboard players operation #Physics.RayDirectionLocal.z Physics += #Physics.Maths.Value1 Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.8
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionOriginal.z Physics
scoreboard players operation #Physics.RayDirectionLocal.z Physics += #Physics.Maths.Value1 Physics

# Compress the object's dimensions to a unit cube, and adjust the ray origin and direction accordingly
execute store result score #Physics.RayPosLocalScaled.x Physics run scoreboard players operation #Physics.RayPosLocal.x Physics /= @s Physics.Object.Dimension.x
execute store result score #Physics.RayPosLocalScaled.y Physics run scoreboard players operation #Physics.RayPosLocal.y Physics /= @s Physics.Object.Dimension.y
execute store result score #Physics.RayPosLocalScaled.z Physics run scoreboard players operation #Physics.RayPosLocal.z Physics /= @s Physics.Object.Dimension.z
scoreboard players operation #Physics.RayDirectionLocal.x Physics /= @s Physics.Object.Dimension.x
scoreboard players operation #Physics.RayDirectionLocal.y Physics /= @s Physics.Object.Dimension.y
scoreboard players operation #Physics.RayDirectionLocal.z Physics /= @s Physics.Object.Dimension.z

# Check if / where the ray hits the object
# (Important): The local position is scaled up by 1,000x (So 1,000,000x in total) to provide accuracy when calculating t.
# (Important): The 2nd check for each face explicitly allows for punching the object while facing the backside of a surface.
scoreboard players operation #Physics.RayPosLocalScaled.x Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.RayPosLocalScaled.y Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.RayPosLocalScaled.z Physics *= #Physics.Constants.1000 Physics

scoreboard players operation #Physics.MinDistancePrev Physics = #Physics.MinDistance Physics

    # x axis
    execute if score #Physics.RayPosLocal.x Physics matches ..-500 if score #Physics.RayDirectionLocal.x Physics matches 0.. run function physics:zprivate/line_of_sight/check_ray_intersections/precise/0
    execute if score #Physics.RayPosLocal.x Physics matches -499.. if score #Physics.RayDirectionLocal.x Physics matches ..-1 run function physics:zprivate/line_of_sight/check_ray_intersections/precise/0

    execute if score #Physics.RayPosLocal.x Physics matches 500.. if score #Physics.RayDirectionLocal.x Physics matches ..-1 run function physics:zprivate/line_of_sight/check_ray_intersections/precise/1
    execute if score #Physics.RayPosLocal.x Physics matches ..499 if score #Physics.RayDirectionLocal.x Physics matches 0.. run function physics:zprivate/line_of_sight/check_ray_intersections/precise/1

    # y axis
    execute if score #Physics.RayPosLocal.y Physics matches ..-500 if score #Physics.RayDirectionLocal.y Physics matches 0.. run function physics:zprivate/line_of_sight/check_ray_intersections/precise/2
    execute if score #Physics.RayPosLocal.y Physics matches -499.. if score #Physics.RayDirectionLocal.y Physics matches ..-1 run function physics:zprivate/line_of_sight/check_ray_intersections/precise/2

    execute if score #Physics.RayPosLocal.y Physics matches 500.. if score #Physics.RayDirectionLocal.y Physics matches ..-1 run function physics:zprivate/line_of_sight/check_ray_intersections/precise/3
    execute if score #Physics.RayPosLocal.y Physics matches ..499 if score #Physics.RayDirectionLocal.y Physics matches 0.. run function physics:zprivate/line_of_sight/check_ray_intersections/precise/3

    # z axis
    execute if score #Physics.RayPosLocal.z Physics matches ..-500 if score #Physics.RayDirectionLocal.z Physics matches 0.. run function physics:zprivate/line_of_sight/check_ray_intersections/precise/4
    execute if score #Physics.RayPosLocal.z Physics matches -499.. if score #Physics.RayDirectionLocal.z Physics matches ..-1 run function physics:zprivate/line_of_sight/check_ray_intersections/precise/4

    execute if score #Physics.RayPosLocal.z Physics matches 500.. if score #Physics.RayDirectionLocal.z Physics matches ..-1 run function physics:zprivate/line_of_sight/check_ray_intersections/precise/5
    execute if score #Physics.RayPosLocal.z Physics matches ..499 if score #Physics.RayDirectionLocal.z Physics matches 0.. run function physics:zprivate/line_of_sight/check_ray_intersections/precise/5

execute unless score #Physics.MinDistance Physics = #Physics.MinDistancePrev Physics run scoreboard players operation #Physics.LookingAtID Physics = @s Physics.Object.ID
