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
data remove storage physics:object data
scoreboard players operation #Physics.Maths.IntermediateResult.Max Physics.Value = #Physics.SetAttribute.Dimension.x Physics.Value
execute if score #Physics.Maths.IntermediateResult.Max Physics.Value < #Physics.SetAttribute.Dimension.y Physics.Value run scoreboard players operation #Physics.Maths.IntermediateResult.Max Physics.Value = #Physics.SetAttribute.Dimension.y Physics.Value
execute if score #Physics.Maths.IntermediateResult.Max Physics.Value < #Physics.SetAttribute.Dimension.z Physics.Value run scoreboard players operation #Physics.Maths.IntermediateResult.Max Physics.Value = #Physics.SetAttribute.Dimension.z Physics.Value
execute store result storage physics:object data.width float 0.00015 store result storage physics:object data.height float 0.00015 run scoreboard players get #Physics.Maths.IntermediateResult.Max Physics.Value

# Update the entity's scale & translation
data modify storage physics:object data.transformation set value {scale:[0f,0f,0f],translation:[0f,0f,0f]}
execute store result storage physics:object data.transformation.scale[0] float 0.0001 store result storage physics:object data.transformation.translation[0] float -0.00005 run scoreboard players get #Physics.SetAttribute.Dimension.x Physics.Value
execute store result storage physics:object data.transformation.scale[1] float 0.0001 store result storage physics:object data.transformation.translation[1] float -0.00005 run scoreboard players get #Physics.SetAttribute.Dimension.y Physics.Value
execute store result storage physics:object data.transformation.scale[2] float 0.0001 store result storage physics:object data.transformation.translation[2] float -0.00005 run scoreboard players get #Physics.SetAttribute.Dimension.z Physics.Value
data modify entity @s {} merge from storage physics:object data

# Update the local inverse inertia tensor (Scaling: InverseMass scaled by 1,000,000/x instead of 100,000,000/x)
    # Calculate the inverted local inertia tensor
    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value = @s Physics.Object.Dimension.y
    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value *= #Physics.Maths.IntermediateResult.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.IntermediateResult.Value2 Physics.Value = @s Physics.Object.Dimension.z
    scoreboard players operation #Physics.Maths.IntermediateResult.Value2 Physics.Value *= #Physics.Maths.IntermediateResult.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value += #Physics.Maths.IntermediateResult.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value /= @s Physics.Object.InverseMass
    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value /= #Physics.Constants.12 Physics.Value
    scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.0 1000000000
    scoreboard players operation @s Physics.Object.InverseInertiaTensorLocal.0 /= #Physics.Maths.IntermediateResult.Value1 Physics.Value

    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value = @s Physics.Object.Dimension.x
    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value *= #Physics.Maths.IntermediateResult.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.IntermediateResult.Value2 Physics.Value = @s Physics.Object.Dimension.z
    scoreboard players operation #Physics.Maths.IntermediateResult.Value2 Physics.Value *= #Physics.Maths.IntermediateResult.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value += #Physics.Maths.IntermediateResult.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value /= @s Physics.Object.InverseMass
    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value /= #Physics.Constants.12 Physics.Value
    scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.4 1000000000
    scoreboard players operation @s Physics.Object.InverseInertiaTensorLocal.4 /= #Physics.Maths.IntermediateResult.Value1 Physics.Value

    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value = @s Physics.Object.Dimension.x
    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value *= #Physics.Maths.IntermediateResult.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.IntermediateResult.Value2 Physics.Value = @s Physics.Object.Dimension.y
    scoreboard players operation #Physics.Maths.IntermediateResult.Value2 Physics.Value *= #Physics.Maths.IntermediateResult.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value += #Physics.Maths.IntermediateResult.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value /= @s Physics.Object.InverseMass
    scoreboard players operation #Physics.Maths.IntermediateResult.Value1 Physics.Value /= #Physics.Constants.12 Physics.Value
    scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.8 1000000000
    scoreboard players operation @s Physics.Object.InverseInertiaTensorLocal.8 /= #Physics.Maths.IntermediateResult.Value1 Physics.Value
