# Set the object's inverse mass
scoreboard players add #Physics.SetAttribute.InverseMass Physics.Value 0
scoreboard players operation @s Physics.Object.InverseMass = #Physics.SetAttribute.InverseMass Physics.Value
execute if score #Physics.SetAttribute.InverseMass Physics.Value matches 1000000001.. run scoreboard players set @s Physics.Object.InverseMass 1000000000
execute if score #Physics.SetAttribute.InverseMass Physics.Value matches ..0 run scoreboard players set @s Physics.Object.InverseMass 1


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
