# Set the object's inverse mass based on its mass
scoreboard players add #Physics.SetAttribute.InverseMass Physics.Value 0
scoreboard players set @s Physics.Object.InverseMass 1000000000
execute if score #Physics.SetAttribute.Mass Physics.Value matches ..0 run scoreboard players set @s Physics.Object.InverseMass 1

scoreboard players operation @s Physics.Object.InverseMass /= #Physics.SetAttribute.Mass Physics.Value

# Update the local inverse inertia tensor (Scaling: InverseMass scaled by 1,000,000/x instead of 100,000,000/x)
# (Important): To prevent an overflow when squaring the dimension, I calculate <added squared dimensions / inversemass> at a scale where the added squared dimensions are 100x too small, but then instead of dividing by 12 after the division, I multiply by 833 and then divide by 100, so that the end result is scaled the same.
    # Calculate the inverted local inertia tensor
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Dimension.y
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.Temp.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Dimension.z
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= @s Physics.Object.InverseMass
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Constants.833 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.100 Physics.Value
    scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.0 1000000000
    scoreboard players operation @s Physics.Object.InverseInertiaTensorLocal.0 /= #Physics.Maths.Temp.Value1 Physics.Value

    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Dimension.x
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.Temp.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Dimension.z
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= @s Physics.Object.InverseMass
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Constants.833 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.100 Physics.Value
    scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.4 1000000000
    scoreboard players operation @s Physics.Object.InverseInertiaTensorLocal.4 /= #Physics.Maths.Temp.Value1 Physics.Value

    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Dimension.x
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.Temp.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Dimension.y
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= @s Physics.Object.InverseMass
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Constants.833 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.100 Physics.Value
    scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.8 1000000000
    scoreboard players operation @s Physics.Object.InverseInertiaTensorLocal.8 /= #Physics.Maths.Temp.Value1 Physics.Value
