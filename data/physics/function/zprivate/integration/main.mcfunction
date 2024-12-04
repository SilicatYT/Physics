# TODO: If no forces, impulses or torque has been added, don't run this function

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

# Update angular velocity (TODO)
scoreboard players operation @s Physics.Object.AngularVelocity.x *= #Physics.Global.AngularDamping Physics.Value
scoreboard players operation @s Physics.Object.AngularVelocity.x /= #Physics.Constants.100 Physics.Value
scoreboard players operation @s Physics.Object.AngularVelocity.y *= #Physics.Global.AngularDamping Physics.Value
scoreboard players operation @s Physics.Object.AngularVelocity.y /= #Physics.Constants.100 Physics.Value
scoreboard players operation @s Physics.Object.AngularVelocity.z *= #Physics.Global.AngularDamping Physics.Value
scoreboard players operation @s Physics.Object.AngularVelocity.z /= #Physics.Constants.100 Physics.Value
execute if score @s Physics.Object.AngularVelocity.x matches ..-1 run scoreboard players add @s Physics.Object.AngularVelocity.x 1
execute if score @s Physics.Object.AngularVelocity.y matches ..-1 run scoreboard players add @s Physics.Object.AngularVelocity.y 1
execute if score @s Physics.Object.AngularVelocity.z matches ..-1 run scoreboard players add @s Physics.Object.AngularVelocity.z 1

# Update orientation
    # Calculate new quaternions (q' = q + (1/2 * AngularVelocity * q)
    # (Important): Need to divide each component by 1,000 after they're multiplied together, so the end result is still only scaled by 1,000x
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.AngularVelocity.x
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.Orientation.a
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.AngularVelocity.y
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.Orientation.z
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.AngularVelocity.z
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.Orientation.y
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.2000 Physics.Value
    execute store result score #Physics.Maths.SquareRoot.Input Physics.Value run scoreboard players operation @s Physics.Object.Orientation.x += #Physics.Maths.Temp.Value1 Physics.Value

    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.AngularVelocity.y
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.Orientation.a
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.AngularVelocity.z
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.Orientation.x
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.AngularVelocity.x
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.Orientation.z
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.2000 Physics.Value
    execute store result score #Physics.Maths.Temp.Value3 Physics.Value run scoreboard players operation @s Physics.Object.Orientation.y += #Physics.Maths.Temp.Value1 Physics.Value

    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.AngularVelocity.z
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.Orientation.a
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.AngularVelocity.x
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.Orientation.y
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.AngularVelocity.y
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.Orientation.x
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value -= #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.2000 Physics.Value
    execute store result score #Physics.Maths.Temp.Value4 Physics.Value run scoreboard players operation @s Physics.Object.Orientation.z += #Physics.Maths.Temp.Value1 Physics.Value

    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.AngularVelocity.x
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.Orientation.x
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.AngularVelocity.y
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.Orientation.y
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.AngularVelocity.z
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.Orientation.z
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.2000 Physics.Value
    execute store result score #Physics.Maths.Temp.Value5 Physics.Value run scoreboard players operation @s Physics.Object.Orientation.a -= #Physics.Maths.Temp.Value1 Physics.Value

    # Re-normalize the quaternions
    # (Important): Because of the squaring, the result is scaled too much, or rather dividing by the square root would get rid of the scaling. So I need to multiply the quaternions by 1,000x first.
    scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value *= #Physics.Maths.SquareRoot.Input Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value3 Physics.Value *= #Physics.Maths.Temp.Value3 Physics.Value
    scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value3 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value4 Physics.Value *= #Physics.Maths.Temp.Value4 Physics.Value
    scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value4 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value5 Physics.Value *= #Physics.Maths.Temp.Value5 Physics.Value
    scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value += #Physics.Maths.Temp.Value5 Physics.Value
    function physics:zprivate/maths/get_square_root

    scoreboard players operation @s Physics.Object.Orientation.x *= #Physics.Constants.1000 Physics.Value
    scoreboard players operation @s Physics.Object.Orientation.y *= #Physics.Constants.1000 Physics.Value
    scoreboard players operation @s Physics.Object.Orientation.z *= #Physics.Constants.1000 Physics.Value
    scoreboard players operation @s Physics.Object.Orientation.a *= #Physics.Constants.1000 Physics.Value
    execute store result storage physics:temp data.Integration.transformation.left_rotation[0] float 0.001 run scoreboard players operation @s Physics.Object.Orientation.x /= #Physics.Maths.SquareRoot.Output Physics.Value
    execute store result storage physics:temp data.Integration.transformation.left_rotation[1] float 0.001 run scoreboard players operation @s Physics.Object.Orientation.y /= #Physics.Maths.SquareRoot.Output Physics.Value
    execute store result storage physics:temp data.Integration.transformation.left_rotation[2] float 0.001 run scoreboard players operation @s Physics.Object.Orientation.z /= #Physics.Maths.SquareRoot.Output Physics.Value
    execute store result storage physics:temp data.Integration.transformation.left_rotation[3] float 0.001 run scoreboard players operation @s Physics.Object.Orientation.a /= #Physics.Maths.SquareRoot.Output Physics.Value

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
data modify entity @s {} merge from storage physics:temp data.Integration
