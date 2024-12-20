# TODO: If no forces, impulses or torque have been added, don't run this function
# NOTE: As an impulse, collisions with other objects count as well. Those can displace the object.

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
    # AngularAcceleration = InverseGlobalInertiaTensor * AccumulatedTorque
    # (Important): InverseGlobalInertiaTensor is scaled by 100,000x and AccumulatedTorque is scaled by 1,000x.
    scoreboard players operation #Physics.Maths.AngularAcceleration.x Physics.Value = @s Physics.Object.InverseInertiaTensorGlobal.0
    scoreboard players operation #Physics.Maths.AngularAcceleration.x Physics.Value *= @s Physics.Object.AccumulatedTorque.x
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.InverseInertiaTensorGlobal.1
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.AccumulatedTorque.y
    scoreboard players operation #Physics.Maths.AngularAcceleration.x Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.InverseInertiaTensorGlobal.2
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.AccumulatedTorque.z
    scoreboard players operation #Physics.Maths.AngularAcceleration.x Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.AngularAcceleration.x Physics.Value /= #Physics.Constants.100000 Physics.Value

    scoreboard players operation #Physics.Maths.AngularAcceleration.y Physics.Value = @s Physics.Object.InverseInertiaTensorGlobal.3
    scoreboard players operation #Physics.Maths.AngularAcceleration.y Physics.Value *= @s Physics.Object.AccumulatedTorque.x
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.InverseInertiaTensorGlobal.4
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.AccumulatedTorque.y
    scoreboard players operation #Physics.Maths.AngularAcceleration.y Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.InverseInertiaTensorGlobal.5
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.AccumulatedTorque.z
    scoreboard players operation #Physics.Maths.AngularAcceleration.y Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.AngularAcceleration.y Physics.Value /= #Physics.Constants.100000 Physics.Value

    scoreboard players operation #Physics.Maths.AngularAcceleration.z Physics.Value = @s Physics.Object.InverseInertiaTensorGlobal.6
    scoreboard players operation #Physics.Maths.AngularAcceleration.z Physics.Value *= @s Physics.Object.AccumulatedTorque.x
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.InverseInertiaTensorGlobal.7
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.AccumulatedTorque.y
    scoreboard players operation #Physics.Maths.AngularAcceleration.z Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.InverseInertiaTensorGlobal.8
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.AccumulatedTorque.z
    scoreboard players operation #Physics.Maths.AngularAcceleration.z Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.AngularAcceleration.z Physics.Value /= #Physics.Constants.100000 Physics.Value

    # Add angular acceleration to angular velocity
    scoreboard players operation @s Physics.Object.AngularVelocity.x += #Physics.Maths.AngularAcceleration.x Physics.Value
    scoreboard players operation @s Physics.Object.AngularVelocity.y += #Physics.Maths.AngularAcceleration.y Physics.Value
    scoreboard players operation @s Physics.Object.AngularVelocity.z += #Physics.Maths.AngularAcceleration.z Physics.Value

    # Apply angular damping
    scoreboard players operation @s Physics.Object.AngularVelocity.x *= #Physics.Global.AngularDamping Physics.Value
    scoreboard players operation @s Physics.Object.AngularVelocity.x /= #Physics.Constants.100 Physics.Value
    scoreboard players operation @s Physics.Object.AngularVelocity.y *= #Physics.Global.AngularDamping Physics.Value
    scoreboard players operation @s Physics.Object.AngularVelocity.y /= #Physics.Constants.100 Physics.Value
    scoreboard players operation @s Physics.Object.AngularVelocity.z *= #Physics.Global.AngularDamping Physics.Value
    scoreboard players operation @s Physics.Object.AngularVelocity.z /= #Physics.Constants.100 Physics.Value

    # Correct for rounding
    execute if score @s Physics.Object.AngularVelocity.x matches ..-1 run scoreboard players add @s Physics.Object.AngularVelocity.x 1
    execute if score @s Physics.Object.AngularVelocity.y matches ..-1 run scoreboard players add @s Physics.Object.AngularVelocity.y 1
    execute if score @s Physics.Object.AngularVelocity.z matches ..-1 run scoreboard players add @s Physics.Object.AngularVelocity.z 1

# Update orientation
    # Calculate new quaternions: q' = q + (1/2 * AngularVelocity * q)
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

    # Inverse global inertia tensor: R * I * R_transpose
    # (Important): InverseInertiaTensorLocal is scaled by 1,000,000,000x and RotationMatrix is scaled by 1,000x. The rotation matrix can have values from -1,000 to 1,000. So to avoid overflow, I first divide the local inertia tensor by 1,000, then multiply it by the rotation matrix. Then I divide it by 10,000 again so I can actually calculate with it. Now it's scaled by 100,000x.
        # temp = R * I_local
        execute store result score @s Physics.Object.InverseInertiaTensorGlobal.3 store result score @s Physics.Object.InverseInertiaTensorGlobal.6 run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 = @s Physics.Object.InverseInertiaTensorLocal.0
        execute store result score @s Physics.Object.InverseInertiaTensorGlobal.4 store result score @s Physics.Object.InverseInertiaTensorGlobal.7 run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 = @s Physics.Object.InverseInertiaTensorLocal.4
        execute store result score @s Physics.Object.InverseInertiaTensorGlobal.5 store result score @s Physics.Object.InverseInertiaTensorGlobal.8 run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 = @s Physics.Object.InverseInertiaTensorLocal.8

        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 /= #Physics.Constants.1000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 /= #Physics.Constants.1000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 /= #Physics.Constants.1000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.3 /= #Physics.Constants.1000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.4 /= #Physics.Constants.1000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.5 /= #Physics.Constants.1000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.6 /= #Physics.Constants.1000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.7 /= #Physics.Constants.1000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.8 /= #Physics.Constants.1000 Physics.Value

        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 *= @s Physics.Object.RotationMatrix.0
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 *= @s Physics.Object.RotationMatrix.1
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 *= @s Physics.Object.RotationMatrix.2
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.3 *= @s Physics.Object.RotationMatrix.3
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.4 *= @s Physics.Object.RotationMatrix.4
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.5 *= @s Physics.Object.RotationMatrix.5
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.6 *= @s Physics.Object.RotationMatrix.6
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.7 *= @s Physics.Object.RotationMatrix.7
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.8 *= @s Physics.Object.RotationMatrix.8

        execute store result score #Physics.Maths.Temp.Value3 Physics.Value store result score #Physics.Maths.Temp.Value5 Physics.Value run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 /= #Physics.Constants.1000 Physics.Value
        execute store result score #Physics.Maths.Temp.Value1 Physics.Value store result score #Physics.Maths.Temp.Value6 Physics.Value run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 /= #Physics.Constants.1000 Physics.Value
        execute store result score #Physics.Maths.Temp.Value2 Physics.Value store result score #Physics.Maths.Temp.Value4 Physics.Value run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 /= #Physics.Constants.1000 Physics.Value
        execute store result score #Physics.Maths.Temp.Value9 Physics.Value store result score #Physics.Maths.Temp.Value11 Physics.Value run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.3 /= #Physics.Constants.1000 Physics.Value
        execute store result score #Physics.Maths.Temp.Value7 Physics.Value store result score #Physics.Maths.Temp.Value12 Physics.Value run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.4 /= #Physics.Constants.1000 Physics.Value
        execute store result score #Physics.Maths.Temp.Value8 Physics.Value store result score #Physics.Maths.Temp.Value10 Physics.Value run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.5 /= #Physics.Constants.1000 Physics.Value
        execute store result score #Physics.Maths.Temp.Value15 Physics.Value store result score #Physics.Maths.Temp.Value17 Physics.Value run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.6 /= #Physics.Constants.1000 Physics.Value
        execute store result score #Physics.Maths.Temp.Value13 Physics.Value store result score #Physics.Maths.Temp.Value18 Physics.Value run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.7 /= #Physics.Constants.1000 Physics.Value
        execute store result score #Physics.Maths.Temp.Value14 Physics.Value store result score #Physics.Maths.Temp.Value16 Physics.Value run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.8 /= #Physics.Constants.1000 Physics.Value

        # I_global = temp * R_transpose
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 *= @s Physics.Object.RotationMatrixTranspose.0
        scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.3
        scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.6
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 += #Physics.Maths.Temp.Value1 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 += #Physics.Maths.Temp.Value2 Physics.Value

        scoreboard players operation #Physics.Maths.Temp.Value3 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.1
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 *= @s Physics.Object.RotationMatrixTranspose.4
        scoreboard players operation #Physics.Maths.Temp.Value4 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.7
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 += #Physics.Maths.Temp.Value3 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 += #Physics.Maths.Temp.Value4 Physics.Value

        scoreboard players operation #Physics.Maths.Temp.Value5 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.2
        scoreboard players operation #Physics.Maths.Temp.Value6 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.5
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 *= @s Physics.Object.RotationMatrixTranspose.8
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 += #Physics.Maths.Temp.Value5 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 += #Physics.Maths.Temp.Value6 Physics.Value

        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.3 *= @s Physics.Object.RotationMatrixTranspose.0
        scoreboard players operation #Physics.Maths.Temp.Value7 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.3
        scoreboard players operation #Physics.Maths.Temp.Value8 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.6
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.3 += #Physics.Maths.Temp.Value7 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.3 += #Physics.Maths.Temp.Value8 Physics.Value

        scoreboard players operation #Physics.Maths.Temp.Value9 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.1
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.4 *= @s Physics.Object.RotationMatrixTranspose.4
        scoreboard players operation #Physics.Maths.Temp.Value10 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.7
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.4 += #Physics.Maths.Temp.Value9 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.4 += #Physics.Maths.Temp.Value10 Physics.Value

        scoreboard players operation #Physics.Maths.Temp.Value11 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.2
        scoreboard players operation #Physics.Maths.Temp.Value12 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.5
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.5 *= @s Physics.Object.RotationMatrixTranspose.8
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.5 += #Physics.Maths.Temp.Value11 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.5 += #Physics.Maths.Temp.Value12 Physics.Value

        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.6 *= @s Physics.Object.RotationMatrixTranspose.0
        scoreboard players operation #Physics.Maths.Temp.Value13 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.3
        scoreboard players operation #Physics.Maths.Temp.Value14 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.6
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.6 += #Physics.Maths.Temp.Value13 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.6 += #Physics.Maths.Temp.Value14 Physics.Value

        scoreboard players operation #Physics.Maths.Temp.Value15 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.1
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.7 *= @s Physics.Object.RotationMatrixTranspose.4
        scoreboard players operation #Physics.Maths.Temp.Value16 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.7
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.7 += #Physics.Maths.Temp.Value15 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.7 += #Physics.Maths.Temp.Value16 Physics.Value

        scoreboard players operation #Physics.Maths.Temp.Value17 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.2
        scoreboard players operation #Physics.Maths.Temp.Value18 Physics.Value *= @s Physics.Object.RotationMatrixTranspose.5
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.8 *= @s Physics.Object.RotationMatrixTranspose.8
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.8 += #Physics.Maths.Temp.Value17 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.8 += #Physics.Maths.Temp.Value18 Physics.Value

        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 /= #Physics.Constants.10000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 /= #Physics.Constants.10000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 /= #Physics.Constants.10000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.3 /= #Physics.Constants.10000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.4 /= #Physics.Constants.10000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.5 /= #Physics.Constants.10000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.6 /= #Physics.Constants.10000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.7 /= #Physics.Constants.10000 Physics.Value
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.8 /= #Physics.Constants.10000 Physics.Value

    # Object corner positions (Global)
    # (Important): Like in many places of the code, I initially copy certain scores (Like the CornerPos or the Temp values, which are all set to different indexes of the Rotation Matrix) over into the objectives ahead of time, so I don't use an unnecessary "scoreboard players operation ... ... = ... ...". Doing it all in a "store result" is faster, and performance is important here.
    # TODO: ACTUALLY USE STORE RESULT INSTEAD OF COPYING OVER THE SCORE MULTIPLE TIMES
        # Corner 0 (-x, -y, -z)
        scoreboard players operation @s Physics.Object.CornerPos.0.x = @s Physics.Object.RotationMatrix.0
        scoreboard players operation @s Physics.Object.CornerPos.0.x *= @s Physics.Object.BoundingBoxHalvedNegative.x
        scoreboard players operation #Physics.Maths.Temp.Value19 Physics.Value = @s Physics.Object.RotationMatrix.1
        scoreboard players operation #Physics.Maths.Temp.Value19 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.y
        scoreboard players operation @s Physics.Object.CornerPos.0.x += #Physics.Maths.Temp.Value19 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value20 Physics.Value = @s Physics.Object.RotationMatrix.2
        scoreboard players operation #Physics.Maths.Temp.Value20 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.z
        scoreboard players operation @s Physics.Object.CornerPos.0.x += #Physics.Maths.Temp.Value20 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.0.y = @s Physics.Object.RotationMatrix.3
        scoreboard players operation @s Physics.Object.CornerPos.0.y *= @s Physics.Object.BoundingBoxHalvedNegative.x
        scoreboard players operation #Physics.Maths.Temp.Value21 Physics.Value = @s Physics.Object.RotationMatrix.4
        scoreboard players operation #Physics.Maths.Temp.Value21 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.y
        scoreboard players operation @s Physics.Object.CornerPos.0.y += #Physics.Maths.Temp.Value21 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value22 Physics.Value = @s Physics.Object.RotationMatrix.5
        scoreboard players operation #Physics.Maths.Temp.Value22 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.z
        scoreboard players operation @s Physics.Object.CornerPos.0.y += #Physics.Maths.Temp.Value22 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.0.z = @s Physics.Object.RotationMatrix.6
        scoreboard players operation @s Physics.Object.CornerPos.0.z *= @s Physics.Object.BoundingBoxHalvedNegative.x
        scoreboard players operation #Physics.Maths.Temp.Value23 Physics.Value = @s Physics.Object.RotationMatrix.7
        scoreboard players operation #Physics.Maths.Temp.Value23 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.y
        scoreboard players operation @s Physics.Object.CornerPos.0.z += #Physics.Maths.Temp.Value23 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value24 Physics.Value = @s Physics.Object.RotationMatrix.8
        scoreboard players operation #Physics.Maths.Temp.Value24 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.z
        scoreboard players operation @s Physics.Object.CornerPos.0.z += #Physics.Maths.Temp.Value24 Physics.Value

        # Corner 1 (-x, -y, +z)
        scoreboard players operation @s Physics.Object.CornerPos.1.x = @s Physics.Object.RotationMatrix.0
        scoreboard players operation @s Physics.Object.CornerPos.1.x *= @s Physics.Object.BoundingBoxHalvedNegative.x
        scoreboard players operation #Physics.Maths.Temp.Value25 Physics.Value = @s Physics.Object.RotationMatrix.1
        scoreboard players operation #Physics.Maths.Temp.Value25 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.y
        scoreboard players operation @s Physics.Object.CornerPos.1.x += #Physics.Maths.Temp.Value25 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value26 Physics.Value = @s Physics.Object.RotationMatrix.2
        scoreboard players operation #Physics.Maths.Temp.Value26 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.z
        scoreboard players operation @s Physics.Object.CornerPos.1.x += #Physics.Maths.Temp.Value26 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.1.y = @s Physics.Object.RotationMatrix.3
        scoreboard players operation @s Physics.Object.CornerPos.1.y *= @s Physics.Object.BoundingBoxHalvedNegative.x
        scoreboard players operation #Physics.Maths.Temp.Value27 Physics.Value = @s Physics.Object.RotationMatrix.4
        scoreboard players operation #Physics.Maths.Temp.Value27 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.y
        scoreboard players operation @s Physics.Object.CornerPos.1.y += #Physics.Maths.Temp.Value27 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value28 Physics.Value = @s Physics.Object.RotationMatrix.5
        scoreboard players operation #Physics.Maths.Temp.Value28 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.z
        scoreboard players operation @s Physics.Object.CornerPos.1.y += #Physics.Maths.Temp.Value28 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.1.z = @s Physics.Object.RotationMatrix.6
        scoreboard players operation @s Physics.Object.CornerPos.1.z *= @s Physics.Object.BoundingBoxHalvedNegative.x
        scoreboard players operation #Physics.Maths.Temp.Value29 Physics.Value = @s Physics.Object.RotationMatrix.7
        scoreboard players operation #Physics.Maths.Temp.Value29 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.y
        scoreboard players operation @s Physics.Object.CornerPos.1.z += #Physics.Maths.Temp.Value29 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value30 Physics.Value = @s Physics.Object.RotationMatrix.8
        scoreboard players operation #Physics.Maths.Temp.Value30 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.z
        scoreboard players operation @s Physics.Object.CornerPos.1.z += #Physics.Maths.Temp.Value30 Physics.Value

        # Corner 2 (+x, -y, -z)
        scoreboard players operation @s Physics.Object.CornerPos.2.x = @s Physics.Object.RotationMatrix.2
        scoreboard players operation @s Physics.Object.CornerPos.2.x *= @s Physics.Object.BoundingBoxHalvedPositive.x
        scoreboard players operation #Physics.Maths.Temp.Value31 Physics.Value = @s Physics.Object.RotationMatrix.1
        scoreboard players operation #Physics.Maths.Temp.Value31 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.y
        scoreboard players operation @s Physics.Object.CornerPos.2.x += #Physics.Maths.Temp.Value31 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value32 Physics.Value = @s Physics.Object.RotationMatrix.2
        scoreboard players operation #Physics.Maths.Temp.Value32 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.z
        scoreboard players operation @s Physics.Object.CornerPos.2.x += #Physics.Maths.Temp.Value32 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.2.y = @s Physics.Object.RotationMatrix.3
        scoreboard players operation @s Physics.Object.CornerPos.2.y *= @s Physics.Object.BoundingBoxHalvedPositive.x
        scoreboard players operation #Physics.Maths.Temp.Value33 Physics.Value = @s Physics.Object.RotationMatrix.4
        scoreboard players operation #Physics.Maths.Temp.Value33 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.y
        scoreboard players operation @s Physics.Object.CornerPos.2.y += #Physics.Maths.Temp.Value33 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value34 Physics.Value = @s Physics.Object.RotationMatrix.5
        scoreboard players operation #Physics.Maths.Temp.Value34 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.z
        scoreboard players operation @s Physics.Object.CornerPos.2.y += #Physics.Maths.Temp.Value34 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.2.z = @s Physics.Object.RotationMatrix.6
        scoreboard players operation @s Physics.Object.CornerPos.2.z *= @s Physics.Object.BoundingBoxHalvedPositive.x
        scoreboard players operation #Physics.Maths.Temp.Value35 Physics.Value = @s Physics.Object.RotationMatrix.7
        scoreboard players operation #Physics.Maths.Temp.Value35 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.y
        scoreboard players operation @s Physics.Object.CornerPos.2.z += #Physics.Maths.Temp.Value35 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value36 Physics.Value = @s Physics.Object.RotationMatrix.8
        scoreboard players operation #Physics.Maths.Temp.Value36 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.z
        scoreboard players operation @s Physics.Object.CornerPos.2.z += #Physics.Maths.Temp.Value36 Physics.Value

        # Corner 3 (+x, -y, +z)
        scoreboard players operation @s Physics.Object.CornerPos.3.x = @s Physics.Object.RotationMatrix.0
        scoreboard players operation @s Physics.Object.CornerPos.3.x *= @s Physics.Object.BoundingBoxHalvedPositive.x
        scoreboard players operation #Physics.Maths.Temp.Value37 Physics.Value = @s Physics.Object.RotationMatrix.1
        scoreboard players operation #Physics.Maths.Temp.Value37 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.y
        scoreboard players operation @s Physics.Object.CornerPos.3.x += #Physics.Maths.Temp.Value37 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value38 Physics.Value = @s Physics.Object.RotationMatrix.2
        scoreboard players operation #Physics.Maths.Temp.Value38 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.z
        scoreboard players operation @s Physics.Object.CornerPos.3.x += #Physics.Maths.Temp.Value38 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.3.y = @s Physics.Object.RotationMatrix.3
        scoreboard players operation @s Physics.Object.CornerPos.3.y *= @s Physics.Object.BoundingBoxHalvedPositive.x
        scoreboard players operation #Physics.Maths.Temp.Value39 Physics.Value = @s Physics.Object.RotationMatrix.4
        scoreboard players operation #Physics.Maths.Temp.Value39 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.y
        scoreboard players operation @s Physics.Object.CornerPos.3.y += #Physics.Maths.Temp.Value39 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value40 Physics.Value = @s Physics.Object.RotationMatrix.5
        scoreboard players operation #Physics.Maths.Temp.Value40 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.z
        scoreboard players operation @s Physics.Object.CornerPos.3.y += #Physics.Maths.Temp.Value40 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.3.z = @s Physics.Object.RotationMatrix.6
        scoreboard players operation @s Physics.Object.CornerPos.3.z *= @s Physics.Object.BoundingBoxHalvedPositive.x
        scoreboard players operation #Physics.Maths.Temp.Value41 Physics.Value = @s Physics.Object.RotationMatrix.7
        scoreboard players operation #Physics.Maths.Temp.Value41 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.y
        scoreboard players operation @s Physics.Object.CornerPos.3.z += #Physics.Maths.Temp.Value41 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value42 Physics.Value = @s Physics.Object.RotationMatrix.8
        scoreboard players operation #Physics.Maths.Temp.Value42 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.z
        scoreboard players operation @s Physics.Object.CornerPos.3.z += #Physics.Maths.Temp.Value42 Physics.Value

        # Corner 4 (-x, +y, -z)
        scoreboard players operation @s Physics.Object.CornerPos.4.x = @s Physics.Object.RotationMatrix.0
        scoreboard players operation @s Physics.Object.CornerPos.4.x *= @s Physics.Object.BoundingBoxHalvedNegative.x
        scoreboard players operation #Physics.Maths.Temp.Value43 Physics.Value = @s Physics.Object.RotationMatrix.1
        scoreboard players operation #Physics.Maths.Temp.Value43 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.y
        scoreboard players operation @s Physics.Object.CornerPos.4.x += #Physics.Maths.Temp.Value43 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value44 Physics.Value = @s Physics.Object.RotationMatrix.2
        scoreboard players operation #Physics.Maths.Temp.Value44 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.z
        scoreboard players operation @s Physics.Object.CornerPos.4.x += #Physics.Maths.Temp.Value44 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.4.y = @s Physics.Object.RotationMatrix.3
        scoreboard players operation @s Physics.Object.CornerPos.4.y *= @s Physics.Object.BoundingBoxHalvedNegative.x
        scoreboard players operation #Physics.Maths.Temp.Value45 Physics.Value = @s Physics.Object.RotationMatrix.4
        scoreboard players operation #Physics.Maths.Temp.Value45 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.y
        scoreboard players operation @s Physics.Object.CornerPos.4.y += #Physics.Maths.Temp.Value45 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value46 Physics.Value = @s Physics.Object.RotationMatrix.5
        scoreboard players operation #Physics.Maths.Temp.Value46 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.z
        scoreboard players operation @s Physics.Object.CornerPos.4.y += #Physics.Maths.Temp.Value46 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.4.z = @s Physics.Object.RotationMatrix.6
        scoreboard players operation @s Physics.Object.CornerPos.4.z *= @s Physics.Object.BoundingBoxHalvedNegative.x
        scoreboard players operation #Physics.Maths.Temp.Value47 Physics.Value = @s Physics.Object.RotationMatrix.7
        scoreboard players operation #Physics.Maths.Temp.Value47 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.y
        scoreboard players operation @s Physics.Object.CornerPos.4.z += #Physics.Maths.Temp.Value47 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value48 Physics.Value = @s Physics.Object.RotationMatrix.8
        scoreboard players operation #Physics.Maths.Temp.Value48 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.z
        scoreboard players operation @s Physics.Object.CornerPos.4.z += #Physics.Maths.Temp.Value48 Physics.Value

        # Corner 5 (-x, +y, +z)
        scoreboard players operation @s Physics.Object.CornerPos.5.x = @s Physics.Object.RotationMatrix.0
        scoreboard players operation @s Physics.Object.CornerPos.5.x *= @s Physics.Object.BoundingBoxHalvedNegative.x
        scoreboard players operation #Physics.Maths.Temp.Value49 Physics.Value = @s Physics.Object.RotationMatrix.1
        scoreboard players operation #Physics.Maths.Temp.Value49 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.y
        scoreboard players operation @s Physics.Object.CornerPos.5.x += #Physics.Maths.Temp.Value49 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value50 Physics.Value = @s Physics.Object.RotationMatrix.2
        scoreboard players operation #Physics.Maths.Temp.Value50 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.z
        scoreboard players operation @s Physics.Object.CornerPos.5.x += #Physics.Maths.Temp.Value50 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.5.y = @s Physics.Object.RotationMatrix.3
        scoreboard players operation @s Physics.Object.CornerPos.5.y *= @s Physics.Object.BoundingBoxHalvedNegative.x
        scoreboard players operation #Physics.Maths.Temp.Value51 Physics.Value = @s Physics.Object.RotationMatrix.4
        scoreboard players operation #Physics.Maths.Temp.Value51 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.y
        scoreboard players operation @s Physics.Object.CornerPos.5.y += #Physics.Maths.Temp.Value51 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value52 Physics.Value = @s Physics.Object.RotationMatrix.5
        scoreboard players operation #Physics.Maths.Temp.Value52 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.z
        scoreboard players operation @s Physics.Object.CornerPos.5.y += #Physics.Maths.Temp.Value52 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.5.z = @s Physics.Object.RotationMatrix.6
        scoreboard players operation @s Physics.Object.CornerPos.5.z *= @s Physics.Object.BoundingBoxHalvedNegative.x
        scoreboard players operation #Physics.Maths.Temp.Value53 Physics.Value = @s Physics.Object.RotationMatrix.7
        scoreboard players operation #Physics.Maths.Temp.Value53 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.y
        scoreboard players operation @s Physics.Object.CornerPos.5.z += #Physics.Maths.Temp.Value53 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value54 Physics.Value = @s Physics.Object.RotationMatrix.8
        scoreboard players operation #Physics.Maths.Temp.Value54 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.z
        scoreboard players operation @s Physics.Object.CornerPos.5.z += #Physics.Maths.Temp.Value54 Physics.Value

        # Corner 6 (+x, +y, -z)
        scoreboard players operation @s Physics.Object.CornerPos.6.x = @s Physics.Object.RotationMatrix.0
        scoreboard players operation @s Physics.Object.CornerPos.6.x *= @s Physics.Object.BoundingBoxHalvedPositive.x
        scoreboard players operation #Physics.Maths.Temp.Value55 Physics.Value = @s Physics.Object.RotationMatrix.1
        scoreboard players operation #Physics.Maths.Temp.Value55 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.y
        scoreboard players operation @s Physics.Object.CornerPos.6.x += #Physics.Maths.Temp.Value55 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value56 Physics.Value = @s Physics.Object.RotationMatrix.2
        scoreboard players operation #Physics.Maths.Temp.Value56 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.z
        scoreboard players operation @s Physics.Object.CornerPos.6.x += #Physics.Maths.Temp.Value56 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.6.y = @s Physics.Object.RotationMatrix.3
        scoreboard players operation @s Physics.Object.CornerPos.6.y *= @s Physics.Object.BoundingBoxHalvedPositive.x
        scoreboard players operation #Physics.Maths.Temp.Value57 Physics.Value = @s Physics.Object.RotationMatrix.4
        scoreboard players operation #Physics.Maths.Temp.Value57 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.y
        scoreboard players operation @s Physics.Object.CornerPos.6.y += #Physics.Maths.Temp.Value57 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value58 Physics.Value = @s Physics.Object.RotationMatrix.5
        scoreboard players operation #Physics.Maths.Temp.Value58 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.z
        scoreboard players operation @s Physics.Object.CornerPos.6.y += #Physics.Maths.Temp.Value58 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.6.z = @s Physics.Object.RotationMatrix.6
        scoreboard players operation @s Physics.Object.CornerPos.6.z *= @s Physics.Object.BoundingBoxHalvedPositive.x
        scoreboard players operation #Physics.Maths.Temp.Value59 Physics.Value = @s Physics.Object.RotationMatrix.7
        scoreboard players operation #Physics.Maths.Temp.Value59 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.y
        scoreboard players operation @s Physics.Object.CornerPos.6.z += #Physics.Maths.Temp.Value59 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value60 Physics.Value = @s Physics.Object.RotationMatrix.8
        scoreboard players operation #Physics.Maths.Temp.Value60 Physics.Value *= @s Physics.Object.BoundingBoxHalvedNegative.z
        scoreboard players operation @s Physics.Object.CornerPos.6.z += #Physics.Maths.Temp.Value60 Physics.Value

        # Corner 7 (+x, +y, +z)
        scoreboard players operation @s Physics.Object.CornerPos.7.x = @s Physics.Object.RotationMatrix.0
        scoreboard players operation @s Physics.Object.CornerPos.7.x *= @s Physics.Object.BoundingBoxHalvedPositive.x
        scoreboard players operation #Physics.Maths.Temp.Value61 Physics.Value = @s Physics.Object.RotationMatrix.1
        scoreboard players operation #Physics.Maths.Temp.Value61 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.y
        scoreboard players operation @s Physics.Object.CornerPos.7.x += #Physics.Maths.Temp.Value61 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value62 Physics.Value = @s Physics.Object.RotationMatrix.2
        scoreboard players operation #Physics.Maths.Temp.Value62 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.z
        scoreboard players operation @s Physics.Object.CornerPos.7.x += #Physics.Maths.Temp.Value62 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.7.y = @s Physics.Object.RotationMatrix.3
        scoreboard players operation @s Physics.Object.CornerPos.7.y *= @s Physics.Object.BoundingBoxHalvedPositive.x
        scoreboard players operation #Physics.Maths.Temp.Value63 Physics.Value = @s Physics.Object.RotationMatrix.4
        scoreboard players operation #Physics.Maths.Temp.Value63 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.y
        scoreboard players operation @s Physics.Object.CornerPos.7.y += #Physics.Maths.Temp.Value63 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value64 Physics.Value = @s Physics.Object.RotationMatrix.5
        scoreboard players operation #Physics.Maths.Temp.Value64 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.z
        scoreboard players operation @s Physics.Object.CornerPos.7.y += #Physics.Maths.Temp.Value64 Physics.Value

        scoreboard players operation @s Physics.Object.CornerPos.7.z = @s Physics.Object.RotationMatrix.6
        scoreboard players operation @s Physics.Object.CornerPos.7.z *= @s Physics.Object.BoundingBoxHalvedPositive.x
        scoreboard players operation #Physics.Maths.Temp.Value65 Physics.Value = @s Physics.Object.RotationMatrix.7
        scoreboard players operation #Physics.Maths.Temp.Value65 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.y
        scoreboard players operation @s Physics.Object.CornerPos.7.z += #Physics.Maths.Temp.Value65 Physics.Value
        scoreboard players operation #Physics.Maths.Temp.Value66 Physics.Value = @s Physics.Object.RotationMatrix.8
        scoreboard players operation #Physics.Maths.Temp.Value66 Physics.Value *= @s Physics.Object.BoundingBoxHalvedPositive.z
        scoreboard players operation @s Physics.Object.CornerPos.7.z += #Physics.Maths.Temp.Value66 Physics.Value

    # Min and Max for the bounding box
    #xxxxx

# Clear accumulators
scoreboard players set @s Physics.Object.AccumulatedForce.x 0
scoreboard players set @s Physics.Object.AccumulatedForce.y 0
scoreboard players set @s Physics.Object.AccumulatedForce.z 0

scoreboard players set @s Physics.Object.AccumulatedTorque.x 0
scoreboard players set @s Physics.Object.AccumulatedTorque.y 0
scoreboard players set @s Physics.Object.AccumulatedTorque.z 0

# Update NBT if it changed
data modify entity @s {} merge from storage physics:temp data.Integration
