# Update velocity & apply linear damping
    # (Important) Scale: InverseMass /= 1,000 -> Need to scale down the acceleration by 1/100,000x so the end result is scaled by 1,000x
scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.InverseMass
scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.1000 Physics.Value
scoreboard players operation @s Physics.Object.AccumulatedForce.x *= #Physics.Maths.Temp.Value1 Physics.Value
scoreboard players operation @s Physics.Object.AccumulatedForce.y *= #Physics.Maths.Temp.Value1 Physics.Value
scoreboard players operation @s Physics.Object.AccumulatedForce.z *= #Physics.Maths.Temp.Value1 Physics.Value
scoreboard players operation @s Physics.Object.AccumulatedForce.x /= #Physics.Constants.100000 Physics.Value
scoreboard players operation @s Physics.Object.AccumulatedForce.y /= #Physics.Constants.100000 Physics.Value
scoreboard players operation @s Physics.Object.AccumulatedForce.z /= #Physics.Constants.100000 Physics.Value

scoreboard players operation @s Physics.Object.Velocity.x += @s Physics.Object.AccumulatedForce.x
scoreboard players operation @s Physics.Object.Velocity.x *= #Physics.Global.LinearDamping Physics.Value
scoreboard players operation @s Physics.Object.Velocity.x /= #Physics.Constants.100 Physics.Value

scoreboard players operation @s Physics.Object.Velocity.y += @s Physics.Object.AccumulatedForce.y
scoreboard players operation @s Physics.Object.Velocity.y -= @s Physics.Object.Gravity
scoreboard players operation @s Physics.Object.Velocity.y *= #Physics.Global.LinearDamping Physics.Value
scoreboard players operation @s Physics.Object.Velocity.y /= #Physics.Constants.100 Physics.Value

scoreboard players operation @s Physics.Object.Velocity.z += @s Physics.Object.AccumulatedForce.z
scoreboard players operation @s Physics.Object.Velocity.z *= #Physics.Global.LinearDamping Physics.Value
scoreboard players operation @s Physics.Object.Velocity.z /= #Physics.Constants.100 Physics.Value

execute if score @s Physics.Object.Velocity.x matches ..-1 run scoreboard players add @s Physics.Object.Velocity.x 1
execute if score @s Physics.Object.Velocity.y matches ..-1 run scoreboard players add @s Physics.Object.Velocity.y 1
execute if score @s Physics.Object.Velocity.z matches ..-1 run scoreboard players add @s Physics.Object.Velocity.z 1

# Update position
execute store result storage physics:temp data.Integration.Pos[0] double 0.001 run scoreboard players operation @s Physics.Object.Pos.x += @s Physics.Object.Velocity.x
execute store result storage physics:temp data.Integration.Pos[1] double 0.001 run scoreboard players operation @s Physics.Object.Pos.y += @s Physics.Object.Velocity.y
execute store result storage physics:temp data.Integration.Pos[2] double 0.001 run scoreboard players operation @s Physics.Object.Pos.z += @s Physics.Object.Velocity.z

# Update angular velocity

# Update orientation

# Update derived data
    # Rotation Matrix (from quaternions) & Transpose
    # (Important): End result scaled by 1,000x
        # Element 0: 2*(a^2 + x^2)-1 -> With scale factor of 1,000: (a^2 + x^2)/500-1000
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.Temp.Value1 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Orientation.x
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.Maths.Temp.Value2 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.500 Physics.Value
        execute store result score @s Physics.Object.RotationMatrix.0 store result score @s Physics.Object.RotationMatrixTranspose.0 run scoreboard players remove #Physics.Maths.Temp.Value1 Physics.Value 1000

        # Element 1: 2*(xy - az) -> With scale factor of 1,000: (xy - az)/500
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Orientation.x
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.Orientation.y
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.Orientation.z
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value
        execute store result score @s Physics.Object.RotationMatrix.1 store result score @s Physics.Object.RotationMatrixTranspose.3 run scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.500 Physics.Value

        # Element 2: 2*(xz + ay) -> With scale factor of 1,000: (xz + ay)/500
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Orientation.x
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.Orientation.z
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.Orientation.y
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
        execute store result score @s Physics.Object.RotationMatrix.2 store result score @s Physics.Object.RotationMatrixTranspose.6 run scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.500 Physics.Value

        # Element 3: 2*(xz + ay) -> With scale factor of 1,000: (xz + ay)/500
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Orientation.x
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.Orientation.y
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.Orientation.z
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
        execute store result score @s Physics.Object.RotationMatrix.3 store result score @s Physics.Object.RotationMatrixTranspose.1 run scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.500 Physics.Value

        # Element 4: 2*(a^2 + y^2)-1 -> With scale factor of 1,000: (a^2 + y^2)/500-1000
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.Temp.Value1 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Orientation.y
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.Maths.Temp.Value2 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.500 Physics.Value
        execute store result score @s Physics.Object.RotationMatrix.4 store result score @s Physics.Object.RotationMatrixTranspose.4 run scoreboard players remove #Physics.Maths.Temp.Value1 Physics.Value 1000

        # Element 5: 2*(yz - ax) -> With scale factor of 1,000: (yz - ax)/500
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Orientation.y
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.Orientation.z
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.Orientation.x
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value
        execute store result score @s Physics.Object.RotationMatrix.5 store result score @s Physics.Object.RotationMatrixTranspose.7 run scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.500 Physics.Value

        # Element 6: 2*(xz - ay) -> With scale factor of 1,000: (xz - ay)/500
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Orientation.x
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.Orientation.z
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.Orientation.y
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value
        execute store result score @s Physics.Object.RotationMatrix.6 store result score @s Physics.Object.RotationMatrixTranspose.2 run scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.500 Physics.Value

        # Element 7: 2*(yz + ax) -> With scale factor of 1,000: (yz + ax)/500
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Orientation.y
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.Orientation.z
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.Orientation.x
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
        execute store result score @s Physics.Object.RotationMatrix.7 store result score @s Physics.Object.RotationMatrixTranspose.5 run scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.500 Physics.Value

        # Element 8: 2*(a^2 + z^2) -> With scale factor of 1,000: (a^2 + z^2)/500
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.Temp.Value1 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Orientation.z
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.Maths.Temp.Value2 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.500 Physics.Value
        execute store result score @s Physics.Object.RotationMatrix.8 store result score @s Physics.Object.RotationMatrixTranspose.8 run scoreboard players remove #Physics.Maths.Temp.Value1 Physics.Value 1000

    # Inverse global inertia tensor

# Clear accumulators
scoreboard players set @s Physics.Object.AccumulatedForce.x 0
scoreboard players set @s Physics.Object.AccumulatedForce.y 0
scoreboard players set @s Physics.Object.AccumulatedForce.z 0

scoreboard players set @s Physics.Object.AccumulatedTorque.x 0
scoreboard players set @s Physics.Object.AccumulatedTorque.y 0
scoreboard players set @s Physics.Object.AccumulatedTorque.z 0

# Update NBT if it changed
    # (Important) (TODO): Only apply this if the data has changed. Otherwise it loops the transformation indefinitely, creating an ugly jitter
data modify entity @s {} merge from storage physics:temp data.Integration
