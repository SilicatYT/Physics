# (Important) (TODO): Minor issue is that several scores like the bounding box min and max are not updated when changing dimensions or when summoning the object in the first place, so it can't properly detect collisions in the first tick afterwards.

# Set the object's x, y and z dimensions (width, height and length)
# (Important): Because of the rough hitbox check (I want to save 3 divisions per entity combination that's checked), the max sidelength for a single dimension is restricted to 15.3 blocks
scoreboard players add #Physics.SetAttribute.Dimension.x Physics.Value 0
scoreboard players add #Physics.SetAttribute.Dimension.y Physics.Value 0
scoreboard players add #Physics.SetAttribute.Dimension.z Physics.Value 0
execute if score #Physics.SetAttribute.Dimension.x Physics.Value matches ..0 run scoreboard players set #Physics.SetAttribute.Dimension.x Physics.Value 1
execute if score #Physics.SetAttribute.Dimension.y Physics.Value matches ..0 run scoreboard players set #Physics.SetAttribute.Dimension.y Physics.Value 1
execute if score #Physics.SetAttribute.Dimension.z Physics.Value matches ..0 run scoreboard players set #Physics.SetAttribute.Dimension.z Physics.Value 1
execute if score #Physics.SetAttribute.Dimension.x Physics.Value matches 15301.. run scoreboard players set #Physics.SetAttribute.Dimension.x Physics.Value 15300
execute if score #Physics.SetAttribute.Dimension.y Physics.Value matches 15301.. run scoreboard players set #Physics.SetAttribute.Dimension.y Physics.Value 15300
execute if score #Physics.SetAttribute.Dimension.z Physics.Value matches 15301.. run scoreboard players set #Physics.SetAttribute.Dimension.z Physics.Value 15300

scoreboard players operation @s Physics.Object.Dimension.x = #Physics.SetAttribute.Dimension.x Physics.Value
scoreboard players operation @s Physics.Object.Dimension.y = #Physics.SetAttribute.Dimension.y Physics.Value
scoreboard players operation @s Physics.Object.Dimension.z = #Physics.SetAttribute.Dimension.z Physics.Value

# Update the entity's width and height NBT
data remove storage physics:temp data.Object
scoreboard players operation #Physics.Maths.Temp.Max Physics.Value = #Physics.SetAttribute.Dimension.x Physics.Value
execute if score #Physics.Maths.Temp.Max Physics.Value < #Physics.SetAttribute.Dimension.y Physics.Value run scoreboard players operation #Physics.Maths.Temp.Max Physics.Value = #Physics.SetAttribute.Dimension.y Physics.Value
execute if score #Physics.Maths.Temp.Max Physics.Value < #Physics.SetAttribute.Dimension.z Physics.Value run scoreboard players operation #Physics.Maths.Temp.Max Physics.Value = #Physics.SetAttribute.Dimension.z Physics.Value
execute store result storage physics:temp data.Object.width float 0.0015 store result storage physics:temp data.Object.height float 0.0015 run scoreboard players get #Physics.Maths.Temp.Max Physics.Value

# Update the entity's scale & translation
data modify storage physics:temp data.Object.transformation set value {scale:[0f,0f,0f]}
execute store result storage physics:temp data.Object.transformation.scale[0] float 0.001 run scoreboard players get #Physics.SetAttribute.Dimension.x Physics.Value
execute store result storage physics:temp data.Object.transformation.scale[1] float 0.001 run scoreboard players get #Physics.SetAttribute.Dimension.y Physics.Value
execute store result storage physics:temp data.Object.transformation.scale[2] float 0.001 run scoreboard players get #Physics.SetAttribute.Dimension.z Physics.Value
data modify entity @s {} merge from storage physics:temp data.Object

# Update the interaction hitbox's size
    # Main hitbox
    execute store result storage physics:maths processing.Distance[0] float 0.001 run scoreboard players get #Physics.SetAttribute.Dimension.x Physics.Value
    execute store result storage physics:maths processing.Distance[4] float 0.001 run scoreboard players get #Physics.SetAttribute.Dimension.y Physics.Value
    execute store result storage physics:maths processing.Distance[8] float 0.001 run scoreboard players get #Physics.SetAttribute.Dimension.z Physics.Value
    data modify entity 0-0-0-0-0 transformation set from storage physics:maths processing.Distance
    data modify storage physics:temp data.Distance set from entity 0-0-0-0-0 transformation.scale[0]

    data modify storage physics:temp data.InteractionSize.width set from storage physics:temp data.Distance
    data modify storage physics:temp data.InteractionSize.height set from storage physics:temp data.Distance
    execute on passengers on passengers run data modify entity @s {} merge from storage physics:temp data.InteractionSize

    # Hitbox offset
    execute on passengers store result entity @s height float -0.000001 run data get storage physics:temp data.InteractionSize.height 500000

# Update the local bounding box
scoreboard players operation @s Physics.Object.BoundingBoxHalvedPositive.x = #Physics.SetAttribute.Dimension.x Physics.Value
execute store result score @s Physics.Object.BoundingBoxHalvedNegative.x run scoreboard players operation @s Physics.Object.BoundingBoxHalvedPositive.x /= #Physics.Constants.2 Physics.Value
scoreboard players operation @s Physics.Object.BoundingBoxHalvedNegative.x *= #Physics.Constants.-1 Physics.Value

scoreboard players operation @s Physics.Object.BoundingBoxHalvedPositive.y = #Physics.SetAttribute.Dimension.y Physics.Value
execute store result score @s Physics.Object.BoundingBoxHalvedNegative.y run scoreboard players operation @s Physics.Object.BoundingBoxHalvedPositive.y /= #Physics.Constants.2 Physics.Value
scoreboard players operation @s Physics.Object.BoundingBoxHalvedNegative.y *= #Physics.Constants.-1 Physics.Value

scoreboard players operation @s Physics.Object.BoundingBoxHalvedPositive.z = #Physics.SetAttribute.Dimension.z Physics.Value
execute store result score @s Physics.Object.BoundingBoxHalvedNegative.z run scoreboard players operation @s Physics.Object.BoundingBoxHalvedPositive.z /= #Physics.Constants.2 Physics.Value
scoreboard players operation @s Physics.Object.BoundingBoxHalvedNegative.z *= #Physics.Constants.-1 Physics.Value

# Update the step counts to traverse the bounding box for each axis
scoreboard players operation @s Physics.Object.BoundingBoxStepCount.x = #Physics.SetAttribute.Dimension.x Physics.Value
scoreboard players operation @s Physics.Object.BoundingBoxStepCount.x /= #Physics.Constants.-1000 Physics.Value
scoreboard players operation @s Physics.Object.BoundingBoxStepCount.x *= #Physics.Constants.-1 Physics.Value

scoreboard players operation @s Physics.Object.BoundingBoxStepCount.y = #Physics.SetAttribute.Dimension.y Physics.Value
scoreboard players operation @s Physics.Object.BoundingBoxStepCount.y /= #Physics.Constants.-1000 Physics.Value
scoreboard players operation @s Physics.Object.BoundingBoxStepCount.y *= #Physics.Constants.-1 Physics.Value

scoreboard players operation @s Physics.Object.BoundingBoxStepCount.z = #Physics.SetAttribute.Dimension.z Physics.Value
scoreboard players operation @s Physics.Object.BoundingBoxStepCount.z /= #Physics.Constants.-1000 Physics.Value
scoreboard players operation @s Physics.Object.BoundingBoxStepCount.z *= #Physics.Constants.-1 Physics.Value

# Update the local inverse inertia tensor (Scaling: InverseMass scaled by 1,000,000/x instead of 100,000,000/x)
# (Important): Dimension is scaled 10x bigger here. Might it make more sense to instead scale the inertia tensor smaller? Or would I lose too much accuracy?
    # Calculate the inverted local inertia tensor
    scoreboard players operation @s Physics.Object.Dimension.x *= #Physics.Constants.10 Physics.Value
    scoreboard players operation @s Physics.Object.Dimension.y *= #Physics.Constants.10 Physics.Value
    scoreboard players operation @s Physics.Object.Dimension.z *= #Physics.Constants.10 Physics.Value

    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Dimension.y
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.Temp.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Dimension.z
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= @s Physics.Object.InverseMass
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.12 Physics.Value
    scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.0 1000000000
    scoreboard players operation @s Physics.Object.InverseInertiaTensorLocal.0 /= #Physics.Maths.Temp.Value1 Physics.Value

    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Dimension.x
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.Temp.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Dimension.z
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= @s Physics.Object.InverseMass
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.12 Physics.Value
    scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.4 1000000000
    scoreboard players operation @s Physics.Object.InverseInertiaTensorLocal.4 /= #Physics.Maths.Temp.Value1 Physics.Value

    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Dimension.x
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.Temp.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Dimension.y
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= @s Physics.Object.InverseMass
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.12 Physics.Value
    scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.8 1000000000
    scoreboard players operation @s Physics.Object.InverseInertiaTensorLocal.8 /= #Physics.Maths.Temp.Value1 Physics.Value

    scoreboard players operation @s Physics.Object.Dimension.x /= #Physics.Constants.10 Physics.Value
    scoreboard players operation @s Physics.Object.Dimension.y /= #Physics.Constants.10 Physics.Value
    scoreboard players operation @s Physics.Object.Dimension.z /= #Physics.Constants.10 Physics.Value
