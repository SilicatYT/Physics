# Set the object's x, y and z dimensions (width, height and length)
scoreboard players add #Physics.SetAttribute.Dimension.x Physics.Value 0
scoreboard players add #Physics.SetAttribute.Dimension.y Physics.Value 0
scoreboard players add #Physics.SetAttribute.Dimension.z Physics.Value 0
execute if score #Physics.SetAttribute.Dimension.x Physics.Value matches ..0 run scoreboard players set #Physics.SetAttribute.Dimension.x Physics.Value 1
execute if score #Physics.SetAttribute.Dimension.y Physics.Value matches ..0 run scoreboard players set #Physics.SetAttribute.Dimension.y Physics.Value 1
execute if score #Physics.SetAttribute.Dimension.z Physics.Value matches ..0 run scoreboard players set #Physics.SetAttribute.Dimension.z Physics.Value 1
scoreboard players operation @s Physics.Object.Dimension.x = #Physics.SetAttribute.Dimension.x Physics.Value
scoreboard players operation @s Physics.Object.Dimension.y = #Physics.SetAttribute.Dimension.y Physics.Value
scoreboard players operation @s Physics.Object.Dimension.z = #Physics.SetAttribute.Dimension.z Physics.Value

# Update the entity's width and height NBT
data remove storage physics:temp data.Object
scoreboard players operation #Physics.Maths.Temp.Max Physics.Value = #Physics.SetAttribute.Dimension.x Physics.Value
execute if score #Physics.Maths.Temp.Max Physics.Value < #Physics.SetAttribute.Dimension.y Physics.Value run scoreboard players operation #Physics.Maths.Temp.Max Physics.Value = #Physics.SetAttribute.Dimension.y Physics.Value
execute if score #Physics.Maths.Temp.Max Physics.Value < #Physics.SetAttribute.Dimension.z Physics.Value run scoreboard players operation #Physics.Maths.Temp.Max Physics.Value = #Physics.SetAttribute.Dimension.z Physics.Value
execute store result storage physics:temp data.Object.width float 0.00015 store result storage physics:temp data.Object.height float 0.00015 run scoreboard players get #Physics.Maths.Temp.Max Physics.Value

# Update the entity's scale & translation
data modify storage physics:temp data.Object.transformation set value {scale:[0f,0f,0f],translation:[0f,0f,0f]}
execute store result storage physics:temp data.Object.transformation.scale[0] float 0.0001 store result storage physics:temp data.Object.transformation.translation[0] float -0.00005 run scoreboard players get #Physics.SetAttribute.Dimension.x Physics.Value
execute store result storage physics:temp data.Object.transformation.scale[1] float 0.0001 store result storage physics:temp data.Object.transformation.translation[1] float -0.00005 run scoreboard players get #Physics.SetAttribute.Dimension.y Physics.Value
execute store result storage physics:temp data.Object.transformation.scale[2] float 0.0001 store result storage physics:temp data.Object.transformation.translation[2] float -0.00005 run scoreboard players get #Physics.SetAttribute.Dimension.z Physics.Value
data modify entity @s {} merge from storage physics:temp data.Object

# Update the interaction hitbox's size
    # Main hitbox
    execute store result storage physics:maths processing.Distance[0] float 0.0001 run scoreboard players get #Physics.SetAttribute.Dimension.x Physics.Value
    execute store result storage physics:maths processing.Distance[4] float 0.0001 run scoreboard players get #Physics.SetAttribute.Dimension.y Physics.Value
    execute store result storage physics:maths processing.Distance[8] float 0.0001 run scoreboard players get #Physics.SetAttribute.Dimension.z Physics.Value
    data modify entity 0-0-0-0-0 transformation set from storage physics:maths processing.Distance
    data modify storage physics:temp data.Distance set from entity 0-0-0-0-0 transformation.scale[0]

    data modify storage physics:temp data.InteractionSize.width set from storage physics:temp data.Distance
    data modify storage physics:temp data.InteractionSize.height set from storage physics:temp data.Distance
    execute on passengers on passengers run data modify entity @s {} merge from storage physics:temp data.InteractionSize

    # Hitbox offset
    execute on passengers store result entity @s height float -0.000001 run data get storage physics:temp data.InteractionSize.height 500000

# Teleport to make sure the player doesn't see the transformation, so it doesn't play on repeat
execute at @s run tp @s ~10000 ~ ~10000
execute at @s run tp @s ~-10000 ~ ~-10000

# Update the local inverse inertia tensor (Scaling: InverseMass scaled by 1,000,000/x instead of 100,000,000/x)
    # Calculate the inverted local inertia tensor
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
