# TODO: If no forces, impulses or torque have been added, don't run this function
# NOTE: As an impulse, collisions with other objects count as well. Those can displace the object.

# Update velocity & apply linear damping
    # (Important) Scale: InverseMass /= 1,000 -> Need to scale down the acceleration by 1/100,000x so the end result is scaled by 1,000x
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.InverseMass
scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
scoreboard players operation @s Physics.Object.AccumulatedForce.x *= #Physics.Maths.Value1 Physics
scoreboard players operation @s Physics.Object.AccumulatedForce.y *= #Physics.Maths.Value1 Physics
scoreboard players operation @s Physics.Object.AccumulatedForce.z *= #Physics.Maths.Value1 Physics
scoreboard players operation @s Physics.Object.AccumulatedForce.x /= #Physics.Constants.100000 Physics
scoreboard players operation @s Physics.Object.AccumulatedForce.y /= #Physics.Constants.100000 Physics
scoreboard players operation @s Physics.Object.AccumulatedForce.z /= #Physics.Constants.100000 Physics

scoreboard players operation @s Physics.Object.Velocity.x += @s Physics.Object.AccumulatedForce.x
scoreboard players operation @s Physics.Object.Velocity.x *= #Physics.Global.LinearDamping Physics
scoreboard players operation @s Physics.Object.Velocity.x /= #Physics.Constants.100 Physics

scoreboard players operation @s Physics.Object.Velocity.y += @s Physics.Object.AccumulatedForce.y
scoreboard players operation @s Physics.Object.Velocity.y -= @s Physics.Object.Gravity
scoreboard players operation @s Physics.Object.Velocity.y *= #Physics.Global.LinearDamping Physics
scoreboard players operation @s Physics.Object.Velocity.y /= #Physics.Constants.100 Physics

scoreboard players operation @s Physics.Object.Velocity.z += @s Physics.Object.AccumulatedForce.z
scoreboard players operation @s Physics.Object.Velocity.z *= #Physics.Global.LinearDamping Physics
scoreboard players operation @s Physics.Object.Velocity.z /= #Physics.Constants.100 Physics

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
    scoreboard players operation #Physics.Maths.AngularAcceleration.x Physics = @s Physics.Object.InverseInertiaTensorGlobal.0
    scoreboard players operation #Physics.Maths.AngularAcceleration.x Physics *= @s Physics.Object.AccumulatedTorque.x
    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.InverseInertiaTensorGlobal.1
    scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.AccumulatedTorque.y
    scoreboard players operation #Physics.Maths.AngularAcceleration.x Physics += #Physics.Maths.Value1 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.InverseInertiaTensorGlobal.2
    scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.AccumulatedTorque.z
    scoreboard players operation #Physics.Maths.AngularAcceleration.x Physics += #Physics.Maths.Value1 Physics
    scoreboard players operation #Physics.Maths.AngularAcceleration.x Physics /= #Physics.Constants.100000 Physics

    scoreboard players operation #Physics.Maths.AngularAcceleration.y Physics = @s Physics.Object.InverseInertiaTensorGlobal.3
    scoreboard players operation #Physics.Maths.AngularAcceleration.y Physics *= @s Physics.Object.AccumulatedTorque.x
    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.InverseInertiaTensorGlobal.4
    scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.AccumulatedTorque.y
    scoreboard players operation #Physics.Maths.AngularAcceleration.y Physics += #Physics.Maths.Value1 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.InverseInertiaTensorGlobal.5
    scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.AccumulatedTorque.z
    scoreboard players operation #Physics.Maths.AngularAcceleration.y Physics += #Physics.Maths.Value1 Physics
    scoreboard players operation #Physics.Maths.AngularAcceleration.y Physics /= #Physics.Constants.100000 Physics

    scoreboard players operation #Physics.Maths.AngularAcceleration.z Physics = @s Physics.Object.InverseInertiaTensorGlobal.6
    scoreboard players operation #Physics.Maths.AngularAcceleration.z Physics *= @s Physics.Object.AccumulatedTorque.x
    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.InverseInertiaTensorGlobal.7
    scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.AccumulatedTorque.y
    scoreboard players operation #Physics.Maths.AngularAcceleration.z Physics += #Physics.Maths.Value1 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.InverseInertiaTensorGlobal.8
    scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.AccumulatedTorque.z
    scoreboard players operation #Physics.Maths.AngularAcceleration.z Physics += #Physics.Maths.Value1 Physics
    scoreboard players operation #Physics.Maths.AngularAcceleration.z Physics /= #Physics.Constants.100000 Physics

    # Add angular acceleration to angular velocity
    scoreboard players operation @s Physics.Object.AngularVelocity.x += #Physics.Maths.AngularAcceleration.x Physics
    scoreboard players operation @s Physics.Object.AngularVelocity.y += #Physics.Maths.AngularAcceleration.y Physics
    scoreboard players operation @s Physics.Object.AngularVelocity.z += #Physics.Maths.AngularAcceleration.z Physics

    # Apply angular damping
    scoreboard players operation @s Physics.Object.AngularVelocity.x *= #Physics.Global.AngularDamping Physics
    scoreboard players operation @s Physics.Object.AngularVelocity.x /= #Physics.Constants.100 Physics
    scoreboard players operation @s Physics.Object.AngularVelocity.y *= #Physics.Global.AngularDamping Physics
    scoreboard players operation @s Physics.Object.AngularVelocity.y /= #Physics.Constants.100 Physics
    scoreboard players operation @s Physics.Object.AngularVelocity.z *= #Physics.Global.AngularDamping Physics
    scoreboard players operation @s Physics.Object.AngularVelocity.z /= #Physics.Constants.100 Physics

    # Correct for rounding
    execute if score @s Physics.Object.AngularVelocity.x matches ..-1 run scoreboard players add @s Physics.Object.AngularVelocity.x 1
    execute if score @s Physics.Object.AngularVelocity.y matches ..-1 run scoreboard players add @s Physics.Object.AngularVelocity.y 1
    execute if score @s Physics.Object.AngularVelocity.z matches ..-1 run scoreboard players add @s Physics.Object.AngularVelocity.z 1

# Update orientation
    # Calculate new quaternions: q' = q + (1/2 * AngularVelocity * q)
    # (Important): Need to divide each component by 1,000 after they're multiplied together, so the end result is still only scaled by 1,000x
    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.AngularVelocity.x
    scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Orientation.a
    scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.AngularVelocity.y
    scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Orientation.z
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics
    scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.AngularVelocity.z
    scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Orientation.y
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.Value2 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.2000 Physics
    execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation @s Physics.Object.Orientation.x += #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.AngularVelocity.y
    scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Orientation.a
    scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.AngularVelocity.z
    scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Orientation.x
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics
    scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.AngularVelocity.x
    scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Orientation.z
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.Value2 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.2000 Physics
    execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation @s Physics.Object.Orientation.y += #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.AngularVelocity.z
    scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Orientation.a
    scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.AngularVelocity.x
    scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Orientation.y
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics
    scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.AngularVelocity.y
    scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Orientation.x
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.Value2 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.2000 Physics
    execute store result score #Physics.Maths.Value4 Physics run scoreboard players operation @s Physics.Object.Orientation.z += #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.AngularVelocity.x
    scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Orientation.x
    scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.AngularVelocity.y
    scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Orientation.y
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics
    scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.AngularVelocity.z
    scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Orientation.z
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.2000 Physics
    execute store result score #Physics.Maths.Value5 Physics run scoreboard players operation @s Physics.Object.Orientation.a -= #Physics.Maths.Value1 Physics

    # Re-normalize the quaternions
    # (Important): Because of the squaring, the result is scaled too much, or rather dividing by the square root would get rid of the scaling. So I need to multiply the quaternions by 1,000x first.
    scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
    scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
    scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
    scoreboard players operation #Physics.Maths.Value4 Physics *= #Physics.Maths.Value4 Physics
    scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value4 Physics
    scoreboard players operation #Physics.Maths.Value5 Physics *= #Physics.Maths.Value5 Physics
    scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value5 Physics
    function physics:zprivate/maths/get_square_root

    scoreboard players operation @s Physics.Object.Orientation.x *= #Physics.Constants.1000 Physics
    scoreboard players operation @s Physics.Object.Orientation.y *= #Physics.Constants.1000 Physics
    scoreboard players operation @s Physics.Object.Orientation.z *= #Physics.Constants.1000 Physics
    scoreboard players operation @s Physics.Object.Orientation.a *= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.Integration.transformation.left_rotation[0] float 0.001 run scoreboard players operation @s Physics.Object.Orientation.x /= #Physics.Maths.SquareRoot.Output Physics
    execute store result storage physics:temp data.Integration.transformation.left_rotation[1] float 0.001 run scoreboard players operation @s Physics.Object.Orientation.y /= #Physics.Maths.SquareRoot.Output Physics
    execute store result storage physics:temp data.Integration.transformation.left_rotation[2] float 0.001 run scoreboard players operation @s Physics.Object.Orientation.z /= #Physics.Maths.SquareRoot.Output Physics
    execute store result storage physics:temp data.Integration.transformation.left_rotation[3] float 0.001 run scoreboard players operation @s Physics.Object.Orientation.a /= #Physics.Maths.SquareRoot.Output Physics

# Update derived data
    # Rotation Matrix (from quaternions) & Transpose
    # (Important): End result scaled by 1,000x
        # Element 0: 2*(a^2 + x^2)-1 -> With scale factor of 1,000: (a^2 + x^2)/500-1000
        scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.Value1 Physics
        scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Orientation.x
        scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
        scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics
        scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.500 Physics
        execute store result score @s Physics.Object.RotationMatrix.0 store result score @s Physics.Object.RotationMatrixTranspose.0 store result score @s Physics.Object.CornerPosRelative.0.x store result score @s Physics.Object.CornerPosRelative.1.x store result score @s Physics.Object.CornerPosRelative.2.x store result score @s Physics.Object.CornerPosRelative.3.x store result score @s Physics.Object.CornerPosRelative.4.x store result score @s Physics.Object.CornerPosRelative.5.x store result score @s Physics.Object.CornerPosRelative.6.x store result score @s Physics.Object.CornerPosRelative.7.x store result score @s Physics.Object.Axis.x.x store result score #Physics.Projection.ObjectCorner0.ObjectAxis.x Physics store result score #Physics.Projection.ObjectCorner1.ObjectAxis.x Physics store result score #Physics.Projection.ObjectCorner2.ObjectAxis.x Physics store result score #Physics.Projection.ObjectCorner3.ObjectAxis.x Physics store result score #Physics.Projection.ObjectCenter.ObjectAxis.x Physics run scoreboard players remove #Physics.Maths.Value1 Physics 1000

        # Element 1: 2*(xy - az) -> With scale factor of 1,000: (xy - az)/500
        scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Orientation.x
        scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Orientation.y
        scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Orientation.z
        scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.Value2 Physics
        execute store result score @s Physics.Object.RotationMatrix.1 store result score @s Physics.Object.RotationMatrixTranspose.3 store result score #Physics.Maths.Value19 Physics store result score #Physics.Maths.Value25 Physics store result score #Physics.Maths.Value31 Physics store result score #Physics.Maths.Value37 Physics store result score @s Physics.Object.Axis.y.x store result score #Physics.Projection.ObjectCorner0.ObjectAxis.y Physics store result score #Physics.Projection.ObjectCorner1.ObjectAxis.y Physics store result score #Physics.Projection.ObjectCorner2.ObjectAxis.y Physics store result score #Physics.Projection.ObjectCorner3.ObjectAxis.y Physics store result score #Physics.Projection.ObjectCenter.ObjectAxis.y Physics run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.500 Physics

        # Element 2: 2*(xz + ay) -> With scale factor of 1,000: (xz + ay)/500
        scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Orientation.x
        scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Orientation.z
        scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Orientation.y
        scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics
        execute store result score @s Physics.Object.RotationMatrix.2 store result score @s Physics.Object.RotationMatrixTranspose.6 store result score #Physics.Maths.Value20 Physics store result score #Physics.Maths.Value26 Physics store result score #Physics.Maths.Value32 Physics store result score #Physics.Maths.Value38 Physics store result score @s Physics.Object.Axis.z.x store result score #Physics.Projection.ObjectCorner0.ObjectAxis.z Physics store result score #Physics.Projection.ObjectCorner1.ObjectAxis.z Physics store result score #Physics.Projection.ObjectCorner2.ObjectAxis.z Physics store result score #Physics.Projection.ObjectCorner3.ObjectAxis.z Physics store result score #Physics.Projection.ObjectCenter.ObjectAxis.z Physics run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.500 Physics

        # Element 3: 2*(xz + ay) -> With scale factor of 1,000: (xz + ay)/500
        scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Orientation.x
        scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Orientation.y
        scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Orientation.z
        scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics
        execute store result score @s Physics.Object.RotationMatrix.3 store result score @s Physics.Object.RotationMatrixTranspose.1 store result score @s Physics.Object.CornerPosRelative.0.y store result score @s Physics.Object.CornerPosRelative.1.y store result score @s Physics.Object.CornerPosRelative.2.y store result score @s Physics.Object.CornerPosRelative.3.y store result score @s Physics.Object.CornerPosRelative.4.y store result score @s Physics.Object.CornerPosRelative.5.y store result score @s Physics.Object.CornerPosRelative.6.y store result score @s Physics.Object.CornerPosRelative.7.y store result score @s Physics.Object.Axis.x.y store result score #Physics.Maths.Value43 Physics store result score #Physics.Maths.Value45 Physics store result score #Physics.Maths.Value47 Physics store result score #Physics.Maths.Value49 Physics store result score #Physics.Maths.Value51 Physics run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.500 Physics

        # Element 4: 2*(a^2 + y^2)-1 -> With scale factor of 1,000: (a^2 + y^2)/500-1000
        scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.Value1 Physics
        scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Orientation.y
        scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
        scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics
        scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.500 Physics
        execute store result score @s Physics.Object.RotationMatrix.4 store result score @s Physics.Object.RotationMatrixTranspose.4 store result score #Physics.Maths.Value21 Physics store result score #Physics.Maths.Value27 Physics store result score #Physics.Maths.Value33 Physics store result score #Physics.Maths.Value39 Physics store result score @s Physics.Object.Axis.y.y store result score #Physics.Maths.Value53 Physics store result score #Physics.Maths.Value55 Physics store result score #Physics.Maths.Value57 Physics store result score #Physics.Maths.Value59 Physics store result score #Physics.Maths.Value61 Physics run scoreboard players remove #Physics.Maths.Value1 Physics 1000

        # Element 5: 2*(yz - ax) -> With scale factor of 1,000: (yz - ax)/500
        scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Orientation.y
        scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Orientation.z
        scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Orientation.x
        scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.Value2 Physics
        execute store result score @s Physics.Object.RotationMatrix.5 store result score @s Physics.Object.RotationMatrixTranspose.7 store result score #Physics.Maths.Value22 Physics store result score #Physics.Maths.Value28 Physics store result score #Physics.Maths.Value34 Physics store result score #Physics.Maths.Value40 Physics store result score @s Physics.Object.Axis.z.y store result score #Physics.Maths.Value63 Physics store result score #Physics.Maths.Value65 Physics store result score #Physics.Maths.Value67 Physics store result score #Physics.Maths.Value69 Physics store result score #Physics.Maths.Value71 Physics run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.500 Physics

        # Element 6: 2*(xz - ay) -> With scale factor of 1,000: (xz - ay)/500
        scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Orientation.x
        scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Orientation.z
        scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Orientation.y
        scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.Value2 Physics
        execute store result score @s Physics.Object.RotationMatrix.6 store result score @s Physics.Object.RotationMatrixTranspose.2 store result score @s Physics.Object.CornerPosRelative.0.z store result score @s Physics.Object.CornerPosRelative.1.z store result score @s Physics.Object.CornerPosRelative.2.z store result score @s Physics.Object.CornerPosRelative.3.z store result score @s Physics.Object.CornerPosRelative.4.z store result score @s Physics.Object.CornerPosRelative.5.z store result score @s Physics.Object.CornerPosRelative.6.z store result score @s Physics.Object.CornerPosRelative.7.z store result score @s Physics.Object.Axis.x.z store result score #Physics.Maths.Value44 Physics store result score #Physics.Maths.Value46 Physics store result score #Physics.Maths.Value48 Physics store result score #Physics.Maths.Value50 Physics store result score #Physics.Maths.Value52 Physics run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.500 Physics

        # Element 7: 2*(yz + ax) -> With scale factor of 1,000: (yz + ax)/500
        scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Orientation.y
        scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Orientation.z
        scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Orientation.x
        scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics
        execute store result score @s Physics.Object.RotationMatrix.7 store result score @s Physics.Object.RotationMatrixTranspose.5 store result score #Physics.Maths.Value23 Physics store result score #Physics.Maths.Value29 Physics store result score #Physics.Maths.Value35 Physics store result score #Physics.Maths.Value41 Physics store result score @s Physics.Object.Axis.y.z store result score #Physics.Maths.Value54 Physics store result score #Physics.Maths.Value56 Physics store result score #Physics.Maths.Value58 Physics store result score #Physics.Maths.Value60 Physics store result score #Physics.Maths.Value62 Physics run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.500 Physics

        # Element 8: 2*(a^2 + z^2) -> With scale factor of 1,000: (a^2 + z^2)/500
        scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Orientation.a
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.Value1 Physics
        scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Orientation.z
        scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
        scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics
        scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.500 Physics
        execute store result score @s Physics.Object.RotationMatrix.8 store result score @s Physics.Object.RotationMatrixTranspose.8 store result score #Physics.Maths.Value24 Physics store result score #Physics.Maths.Value30 Physics store result score #Physics.Maths.Value36 Physics store result score #Physics.Maths.Value42 Physics store result score @s Physics.Object.Axis.z.z store result score #Physics.Maths.Value64 Physics store result score #Physics.Maths.Value66 Physics store result score #Physics.Maths.Value68 Physics store result score #Physics.Maths.Value70 Physics store result score #Physics.Maths.Value72 Physics run scoreboard players remove #Physics.Maths.Value1 Physics 1000

    # Inverse global inertia tensor: R * I * R_transpose
    # (Important): InverseInertiaTensorLocal is scaled by 1,000,000,000x and RotationMatrix is scaled by 1,000x. The rotation matrix can have values from -1,000 to 1,000. So to avoid overflow, I first divide the local inertia tensor by 1,000, then multiply it by the rotation matrix. Then I divide it by 10,000 again so I can actually calculate with it. Now it's scaled by 100,000x.
        # temp = R * I_local
        execute store result score @s Physics.Object.InverseInertiaTensorGlobal.3 store result score @s Physics.Object.InverseInertiaTensorGlobal.6 run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 = @s Physics.Object.InverseInertiaTensorLocal.0
        execute store result score @s Physics.Object.InverseInertiaTensorGlobal.4 store result score @s Physics.Object.InverseInertiaTensorGlobal.7 run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 = @s Physics.Object.InverseInertiaTensorLocal.4
        execute store result score @s Physics.Object.InverseInertiaTensorGlobal.5 store result score @s Physics.Object.InverseInertiaTensorGlobal.8 run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 = @s Physics.Object.InverseInertiaTensorLocal.8

        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 /= #Physics.Constants.1000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 /= #Physics.Constants.1000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 /= #Physics.Constants.1000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.3 /= #Physics.Constants.1000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.4 /= #Physics.Constants.1000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.5 /= #Physics.Constants.1000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.6 /= #Physics.Constants.1000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.7 /= #Physics.Constants.1000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.8 /= #Physics.Constants.1000 Physics

        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 *= @s Physics.Object.RotationMatrix.0
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 *= @s Physics.Object.RotationMatrix.1
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 *= @s Physics.Object.RotationMatrix.2
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.3 *= @s Physics.Object.RotationMatrix.3
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.4 *= @s Physics.Object.RotationMatrix.4
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.5 *= @s Physics.Object.RotationMatrix.5
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.6 *= @s Physics.Object.RotationMatrix.6
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.7 *= @s Physics.Object.RotationMatrix.7
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.8 *= @s Physics.Object.RotationMatrix.8

        execute store result score #Physics.Maths.Value3 Physics store result score #Physics.Maths.Value5 Physics run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 /= #Physics.Constants.1000 Physics
        execute store result score #Physics.Maths.Value1 Physics store result score #Physics.Maths.Value6 Physics run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 /= #Physics.Constants.1000 Physics
        execute store result score #Physics.Maths.Value2 Physics store result score #Physics.Maths.Value4 Physics run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 /= #Physics.Constants.1000 Physics
        execute store result score #Physics.Maths.Value9 Physics store result score #Physics.Maths.Value11 Physics run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.3 /= #Physics.Constants.1000 Physics
        execute store result score #Physics.Maths.Value7 Physics store result score #Physics.Maths.Value12 Physics run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.4 /= #Physics.Constants.1000 Physics
        execute store result score #Physics.Maths.Value8 Physics store result score #Physics.Maths.Value10 Physics run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.5 /= #Physics.Constants.1000 Physics
        execute store result score #Physics.Maths.Value15 Physics store result score #Physics.Maths.Value17 Physics run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.6 /= #Physics.Constants.1000 Physics
        execute store result score #Physics.Maths.Value13 Physics store result score #Physics.Maths.Value18 Physics run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.7 /= #Physics.Constants.1000 Physics
        execute store result score #Physics.Maths.Value14 Physics store result score #Physics.Maths.Value16 Physics run scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.8 /= #Physics.Constants.1000 Physics

        # I_global = temp * R_transpose
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 *= @s Physics.Object.RotationMatrixTranspose.0
        scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.RotationMatrixTranspose.3
        scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.RotationMatrixTranspose.6
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 += #Physics.Maths.Value1 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 += #Physics.Maths.Value2 Physics

        scoreboard players operation #Physics.Maths.Value3 Physics *= @s Physics.Object.RotationMatrixTranspose.1
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 *= @s Physics.Object.RotationMatrixTranspose.4
        scoreboard players operation #Physics.Maths.Value4 Physics *= @s Physics.Object.RotationMatrixTranspose.7
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 += #Physics.Maths.Value3 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 += #Physics.Maths.Value4 Physics

        scoreboard players operation #Physics.Maths.Value5 Physics *= @s Physics.Object.RotationMatrixTranspose.2
        scoreboard players operation #Physics.Maths.Value6 Physics *= @s Physics.Object.RotationMatrixTranspose.5
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 *= @s Physics.Object.RotationMatrixTranspose.8
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 += #Physics.Maths.Value5 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 += #Physics.Maths.Value6 Physics

        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.3 *= @s Physics.Object.RotationMatrixTranspose.0
        scoreboard players operation #Physics.Maths.Value7 Physics *= @s Physics.Object.RotationMatrixTranspose.3
        scoreboard players operation #Physics.Maths.Value8 Physics *= @s Physics.Object.RotationMatrixTranspose.6
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.3 += #Physics.Maths.Value7 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.3 += #Physics.Maths.Value8 Physics

        scoreboard players operation #Physics.Maths.Value9 Physics *= @s Physics.Object.RotationMatrixTranspose.1
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.4 *= @s Physics.Object.RotationMatrixTranspose.4
        scoreboard players operation #Physics.Maths.Value10 Physics *= @s Physics.Object.RotationMatrixTranspose.7
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.4 += #Physics.Maths.Value9 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.4 += #Physics.Maths.Value10 Physics

        scoreboard players operation #Physics.Maths.Value11 Physics *= @s Physics.Object.RotationMatrixTranspose.2
        scoreboard players operation #Physics.Maths.Value12 Physics *= @s Physics.Object.RotationMatrixTranspose.5
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.5 *= @s Physics.Object.RotationMatrixTranspose.8
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.5 += #Physics.Maths.Value11 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.5 += #Physics.Maths.Value12 Physics

        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.6 *= @s Physics.Object.RotationMatrixTranspose.0
        scoreboard players operation #Physics.Maths.Value13 Physics *= @s Physics.Object.RotationMatrixTranspose.3
        scoreboard players operation #Physics.Maths.Value14 Physics *= @s Physics.Object.RotationMatrixTranspose.6
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.6 += #Physics.Maths.Value13 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.6 += #Physics.Maths.Value14 Physics

        scoreboard players operation #Physics.Maths.Value15 Physics *= @s Physics.Object.RotationMatrixTranspose.1
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.7 *= @s Physics.Object.RotationMatrixTranspose.4
        scoreboard players operation #Physics.Maths.Value16 Physics *= @s Physics.Object.RotationMatrixTranspose.7
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.7 += #Physics.Maths.Value15 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.7 += #Physics.Maths.Value16 Physics

        scoreboard players operation #Physics.Maths.Value17 Physics *= @s Physics.Object.RotationMatrixTranspose.2
        scoreboard players operation #Physics.Maths.Value18 Physics *= @s Physics.Object.RotationMatrixTranspose.5
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.8 *= @s Physics.Object.RotationMatrixTranspose.8
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.8 += #Physics.Maths.Value17 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.8 += #Physics.Maths.Value18 Physics

        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.0 /= #Physics.Constants.10000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.1 /= #Physics.Constants.10000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.2 /= #Physics.Constants.10000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.3 /= #Physics.Constants.10000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.4 /= #Physics.Constants.10000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.5 /= #Physics.Constants.10000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.6 /= #Physics.Constants.10000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.7 /= #Physics.Constants.10000 Physics
        scoreboard players operation @s Physics.Object.InverseInertiaTensorGlobal.8 /= #Physics.Constants.10000 Physics

    # Object corner positions (Relative to object center)
    # (Important): Like in many places of the code, I initially copy certain scores (Like the CornerPosRelative or the Temp values, which are all set to different indexes of the Rotation Matrix) over into the objectives ahead of time, so I don't use an unnecessary "scoreboard players operation ... ... = ... ...". Doing it all in a "store result" is faster, and performance is important here.
    # (Important): Because I multiply two values together that are each scaled by 1,000x I have to divide the result by 1,000x to keep the scale.

        # Corner 0 (-x, -y, -z)
        scoreboard players operation @s Physics.Object.CornerPosRelative.0.x *= @s Physics.Object.BoundingBoxLocalMin.x
        scoreboard players operation #Physics.Maths.Value19 Physics *= @s Physics.Object.BoundingBoxLocalMin.y
        scoreboard players operation @s Physics.Object.CornerPosRelative.0.x += #Physics.Maths.Value19 Physics
        scoreboard players operation #Physics.Maths.Value20 Physics *= @s Physics.Object.BoundingBoxLocalMin.z
        scoreboard players operation @s Physics.Object.CornerPosRelative.0.x += #Physics.Maths.Value20 Physics
        execute store result score @s Physics.Object.CornerPosRelative.7.x store result score @s Physics.Object.BoundingBoxGlobalMax.x store result score @s Physics.Object.CornerPosGlobal.0.x run scoreboard players operation @s Physics.Object.CornerPosRelative.0.x /= #Physics.Constants.1000 Physics

        scoreboard players operation @s Physics.Object.CornerPosRelative.0.y *= @s Physics.Object.BoundingBoxLocalMin.x
        scoreboard players operation #Physics.Maths.Value21 Physics *= @s Physics.Object.BoundingBoxLocalMin.y
        scoreboard players operation @s Physics.Object.CornerPosRelative.0.y += #Physics.Maths.Value21 Physics
        scoreboard players operation #Physics.Maths.Value22 Physics *= @s Physics.Object.BoundingBoxLocalMin.z
        scoreboard players operation @s Physics.Object.CornerPosRelative.0.y += #Physics.Maths.Value22 Physics
        execute store result score @s Physics.Object.CornerPosRelative.7.y store result score @s Physics.Object.BoundingBoxGlobalMax.y store result score @s Physics.Object.CornerPosGlobal.0.y run scoreboard players operation @s Physics.Object.CornerPosRelative.0.y /= #Physics.Constants.1000 Physics

        scoreboard players operation @s Physics.Object.CornerPosRelative.0.z *= @s Physics.Object.BoundingBoxLocalMin.x
        scoreboard players operation #Physics.Maths.Value23 Physics *= @s Physics.Object.BoundingBoxLocalMin.y
        scoreboard players operation @s Physics.Object.CornerPosRelative.0.z += #Physics.Maths.Value23 Physics
        scoreboard players operation #Physics.Maths.Value24 Physics *= @s Physics.Object.BoundingBoxLocalMin.z
        scoreboard players operation @s Physics.Object.CornerPosRelative.0.z += #Physics.Maths.Value24 Physics
        execute store result score @s Physics.Object.CornerPosRelative.7.z store result score @s Physics.Object.BoundingBoxGlobalMax.z store result score @s Physics.Object.CornerPosGlobal.0.z run scoreboard players operation @s Physics.Object.CornerPosRelative.0.z /= #Physics.Constants.1000 Physics

        # Corner 1 (-x, -y, +z)
        scoreboard players operation @s Physics.Object.CornerPosRelative.1.x *= @s Physics.Object.BoundingBoxLocalMin.x
        scoreboard players operation #Physics.Maths.Value25 Physics *= @s Physics.Object.BoundingBoxLocalMin.y
        scoreboard players operation @s Physics.Object.CornerPosRelative.1.x += #Physics.Maths.Value25 Physics
        scoreboard players operation #Physics.Maths.Value26 Physics *= @s Physics.Object.BoundingBoxLocalMax.z
        scoreboard players operation @s Physics.Object.CornerPosRelative.1.x += #Physics.Maths.Value26 Physics
        execute store result score @s Physics.Object.CornerPosRelative.6.x store result score @s Physics.Object.CornerPosGlobal.1.x run scoreboard players operation @s Physics.Object.CornerPosRelative.1.x /= #Physics.Constants.1000 Physics

        scoreboard players operation @s Physics.Object.CornerPosRelative.1.y *= @s Physics.Object.BoundingBoxLocalMin.x
        scoreboard players operation #Physics.Maths.Value27 Physics *= @s Physics.Object.BoundingBoxLocalMin.y
        scoreboard players operation @s Physics.Object.CornerPosRelative.1.y += #Physics.Maths.Value27 Physics
        scoreboard players operation #Physics.Maths.Value28 Physics *= @s Physics.Object.BoundingBoxLocalMax.z
        scoreboard players operation @s Physics.Object.CornerPosRelative.1.y += #Physics.Maths.Value28 Physics
        execute store result score @s Physics.Object.CornerPosRelative.6.y store result score @s Physics.Object.CornerPosGlobal.1.y run scoreboard players operation @s Physics.Object.CornerPosRelative.1.y /= #Physics.Constants.1000 Physics

        scoreboard players operation @s Physics.Object.CornerPosRelative.1.z *= @s Physics.Object.BoundingBoxLocalMin.x
        scoreboard players operation #Physics.Maths.Value29 Physics *= @s Physics.Object.BoundingBoxLocalMin.y
        scoreboard players operation @s Physics.Object.CornerPosRelative.1.z += #Physics.Maths.Value29 Physics
        scoreboard players operation #Physics.Maths.Value30 Physics *= @s Physics.Object.BoundingBoxLocalMax.z
        scoreboard players operation @s Physics.Object.CornerPosRelative.1.z += #Physics.Maths.Value30 Physics
        execute store result score @s Physics.Object.CornerPosRelative.6.z store result score @s Physics.Object.CornerPosGlobal.1.z run scoreboard players operation @s Physics.Object.CornerPosRelative.1.z /= #Physics.Constants.1000 Physics

        # Corner 2 (+x, -y, -z)
        scoreboard players operation @s Physics.Object.CornerPosRelative.2.x *= @s Physics.Object.BoundingBoxLocalMax.x
        scoreboard players operation #Physics.Maths.Value31 Physics *= @s Physics.Object.BoundingBoxLocalMin.y
        scoreboard players operation @s Physics.Object.CornerPosRelative.2.x += #Physics.Maths.Value31 Physics
        scoreboard players operation #Physics.Maths.Value32 Physics *= @s Physics.Object.BoundingBoxLocalMin.z
        scoreboard players operation @s Physics.Object.CornerPosRelative.2.x += #Physics.Maths.Value32 Physics
        execute store result score @s Physics.Object.CornerPosRelative.5.x store result score @s Physics.Object.CornerPosGlobal.2.x run scoreboard players operation @s Physics.Object.CornerPosRelative.2.x /= #Physics.Constants.1000 Physics

        scoreboard players operation @s Physics.Object.CornerPosRelative.2.y *= @s Physics.Object.BoundingBoxLocalMax.x
        scoreboard players operation #Physics.Maths.Value33 Physics *= @s Physics.Object.BoundingBoxLocalMin.y
        scoreboard players operation @s Physics.Object.CornerPosRelative.2.y += #Physics.Maths.Value33 Physics
        scoreboard players operation #Physics.Maths.Value34 Physics *= @s Physics.Object.BoundingBoxLocalMin.z
        scoreboard players operation @s Physics.Object.CornerPosRelative.2.y += #Physics.Maths.Value34 Physics
        execute store result score @s Physics.Object.CornerPosRelative.5.y store result score @s Physics.Object.CornerPosGlobal.2.y run scoreboard players operation @s Physics.Object.CornerPosRelative.2.y /= #Physics.Constants.1000 Physics

        scoreboard players operation @s Physics.Object.CornerPosRelative.2.z *= @s Physics.Object.BoundingBoxLocalMax.x
        scoreboard players operation #Physics.Maths.Value35 Physics *= @s Physics.Object.BoundingBoxLocalMin.y
        scoreboard players operation @s Physics.Object.CornerPosRelative.2.z += #Physics.Maths.Value35 Physics
        scoreboard players operation #Physics.Maths.Value36 Physics *= @s Physics.Object.BoundingBoxLocalMin.z
        scoreboard players operation @s Physics.Object.CornerPosRelative.2.z += #Physics.Maths.Value36 Physics
        execute store result score @s Physics.Object.CornerPosRelative.5.z store result score @s Physics.Object.CornerPosGlobal.2.z run scoreboard players operation @s Physics.Object.CornerPosRelative.2.z /= #Physics.Constants.1000 Physics

        # Corner 3 (+x, -y, +z)
        scoreboard players operation @s Physics.Object.CornerPosRelative.3.x *= @s Physics.Object.BoundingBoxLocalMax.x
        scoreboard players operation #Physics.Maths.Value37 Physics *= @s Physics.Object.BoundingBoxLocalMin.y
        scoreboard players operation @s Physics.Object.CornerPosRelative.3.x += #Physics.Maths.Value37 Physics
        scoreboard players operation #Physics.Maths.Value38 Physics *= @s Physics.Object.BoundingBoxLocalMax.z
        scoreboard players operation @s Physics.Object.CornerPosRelative.3.x += #Physics.Maths.Value38 Physics
        execute store result score @s Physics.Object.CornerPosRelative.4.x store result score @s Physics.Object.CornerPosGlobal.3.x run scoreboard players operation @s Physics.Object.CornerPosRelative.3.x /= #Physics.Constants.1000 Physics

        scoreboard players operation @s Physics.Object.CornerPosRelative.3.y *= @s Physics.Object.BoundingBoxLocalMax.x
        scoreboard players operation #Physics.Maths.Value39 Physics *= @s Physics.Object.BoundingBoxLocalMin.y
        scoreboard players operation @s Physics.Object.CornerPosRelative.3.y += #Physics.Maths.Value39 Physics
        scoreboard players operation #Physics.Maths.Value40 Physics *= @s Physics.Object.BoundingBoxLocalMax.z
        scoreboard players operation @s Physics.Object.CornerPosRelative.3.y += #Physics.Maths.Value40 Physics
        execute store result score @s Physics.Object.CornerPosRelative.4.y store result score @s Physics.Object.CornerPosGlobal.3.y run scoreboard players operation @s Physics.Object.CornerPosRelative.3.y /= #Physics.Constants.1000 Physics

        scoreboard players operation @s Physics.Object.CornerPosRelative.3.z *= @s Physics.Object.BoundingBoxLocalMax.x
        scoreboard players operation #Physics.Maths.Value41 Physics *= @s Physics.Object.BoundingBoxLocalMin.y
        scoreboard players operation @s Physics.Object.CornerPosRelative.3.z += #Physics.Maths.Value41 Physics
        scoreboard players operation #Physics.Maths.Value42 Physics *= @s Physics.Object.BoundingBoxLocalMax.z
        scoreboard players operation @s Physics.Object.CornerPosRelative.3.z += #Physics.Maths.Value42 Physics
        execute store result score @s Physics.Object.CornerPosRelative.4.z store result score @s Physics.Object.CornerPosGlobal.3.z run scoreboard players operation @s Physics.Object.CornerPosRelative.3.z /= #Physics.Constants.1000 Physics

        # Corner 4 (-x, +y, -z) (Mirrored version of 3)
        execute store result score @s Physics.Object.CornerPosGlobal.4.x run scoreboard players operation @s Physics.Object.CornerPosRelative.4.x *= #Physics.Constants.-1 Physics
        execute store result score @s Physics.Object.CornerPosGlobal.4.y run scoreboard players operation @s Physics.Object.CornerPosRelative.4.y *= #Physics.Constants.-1 Physics
        execute store result score @s Physics.Object.CornerPosGlobal.4.z run scoreboard players operation @s Physics.Object.CornerPosRelative.4.z *= #Physics.Constants.-1 Physics

        # Corner 5 (-x, +y, +z) (Mirrored version of 2)
        execute store result score @s Physics.Object.CornerPosGlobal.5.x run scoreboard players operation @s Physics.Object.CornerPosRelative.5.x *= #Physics.Constants.-1 Physics
        execute store result score @s Physics.Object.CornerPosGlobal.5.y run scoreboard players operation @s Physics.Object.CornerPosRelative.5.y *= #Physics.Constants.-1 Physics
        execute store result score @s Physics.Object.CornerPosGlobal.5.z run scoreboard players operation @s Physics.Object.CornerPosRelative.5.z *= #Physics.Constants.-1 Physics

        # Corner 6 (+x, +y, -z) (Mirrored version of 1)
        execute store result score @s Physics.Object.CornerPosGlobal.6.x run scoreboard players operation @s Physics.Object.CornerPosRelative.6.x *= #Physics.Constants.-1 Physics
        execute store result score @s Physics.Object.CornerPosGlobal.6.y run scoreboard players operation @s Physics.Object.CornerPosRelative.6.y *= #Physics.Constants.-1 Physics
        execute store result score @s Physics.Object.CornerPosGlobal.6.z run scoreboard players operation @s Physics.Object.CornerPosRelative.6.z *= #Physics.Constants.-1 Physics

        # Corner 7 (+x, +y, +z) (Mirrored version of 0)
        execute store result score @s Physics.Object.CornerPosGlobal.7.x run scoreboard players operation @s Physics.Object.CornerPosRelative.7.x *= #Physics.Constants.-1 Physics
        execute store result score @s Physics.Object.CornerPosGlobal.7.y run scoreboard players operation @s Physics.Object.CornerPosRelative.7.y *= #Physics.Constants.-1 Physics
        execute store result score @s Physics.Object.CornerPosGlobal.7.z run scoreboard players operation @s Physics.Object.CornerPosRelative.7.z *= #Physics.Constants.-1 Physics

    # Min and Max for the bounding box (Relative, so I can use it to calculate the StepCount)
    execute if score @s Physics.Object.CornerPosGlobal.1.x > @s Physics.Object.BoundingBoxGlobalMax.x run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.x = @s Physics.Object.CornerPosGlobal.1.x
    execute if score @s Physics.Object.CornerPosGlobal.2.x > @s Physics.Object.BoundingBoxGlobalMax.x run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.x = @s Physics.Object.CornerPosGlobal.2.x
    execute if score @s Physics.Object.CornerPosGlobal.3.x > @s Physics.Object.BoundingBoxGlobalMax.x run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.x = @s Physics.Object.CornerPosGlobal.3.x
    execute if score @s Physics.Object.CornerPosGlobal.4.x > @s Physics.Object.BoundingBoxGlobalMax.x run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.x = @s Physics.Object.CornerPosGlobal.4.x
    execute if score @s Physics.Object.CornerPosGlobal.5.x > @s Physics.Object.BoundingBoxGlobalMax.x run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.x = @s Physics.Object.CornerPosGlobal.5.x
    execute if score @s Physics.Object.CornerPosGlobal.6.x > @s Physics.Object.BoundingBoxGlobalMax.x run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.x = @s Physics.Object.CornerPosGlobal.6.x
    execute if score @s Physics.Object.CornerPosGlobal.7.x > @s Physics.Object.BoundingBoxGlobalMax.x run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.x = @s Physics.Object.CornerPosGlobal.7.x

    execute if score @s Physics.Object.CornerPosGlobal.1.y > @s Physics.Object.BoundingBoxGlobalMax.y run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.y = @s Physics.Object.CornerPosGlobal.1.y
    execute if score @s Physics.Object.CornerPosGlobal.2.y > @s Physics.Object.BoundingBoxGlobalMax.y run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.y = @s Physics.Object.CornerPosGlobal.2.y
    execute if score @s Physics.Object.CornerPosGlobal.3.y > @s Physics.Object.BoundingBoxGlobalMax.y run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.y = @s Physics.Object.CornerPosGlobal.3.y
    execute if score @s Physics.Object.CornerPosGlobal.4.y > @s Physics.Object.BoundingBoxGlobalMax.y run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.y = @s Physics.Object.CornerPosGlobal.4.y
    execute if score @s Physics.Object.CornerPosGlobal.5.y > @s Physics.Object.BoundingBoxGlobalMax.y run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.y = @s Physics.Object.CornerPosGlobal.5.y
    execute if score @s Physics.Object.CornerPosGlobal.6.y > @s Physics.Object.BoundingBoxGlobalMax.y run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.y = @s Physics.Object.CornerPosGlobal.6.y
    execute if score @s Physics.Object.CornerPosGlobal.7.y > @s Physics.Object.BoundingBoxGlobalMax.y run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.y = @s Physics.Object.CornerPosGlobal.7.y

    execute if score @s Physics.Object.CornerPosGlobal.1.z > @s Physics.Object.BoundingBoxGlobalMax.z run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.z = @s Physics.Object.CornerPosGlobal.1.z
    execute if score @s Physics.Object.CornerPosGlobal.2.z > @s Physics.Object.BoundingBoxGlobalMax.z run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.z = @s Physics.Object.CornerPosGlobal.2.z
    execute if score @s Physics.Object.CornerPosGlobal.3.z > @s Physics.Object.BoundingBoxGlobalMax.z run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.z = @s Physics.Object.CornerPosGlobal.3.z
    execute if score @s Physics.Object.CornerPosGlobal.4.z > @s Physics.Object.BoundingBoxGlobalMax.z run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.z = @s Physics.Object.CornerPosGlobal.4.z
    execute if score @s Physics.Object.CornerPosGlobal.5.z > @s Physics.Object.BoundingBoxGlobalMax.z run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.z = @s Physics.Object.CornerPosGlobal.5.z
    execute if score @s Physics.Object.CornerPosGlobal.6.z > @s Physics.Object.BoundingBoxGlobalMax.z run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.z = @s Physics.Object.CornerPosGlobal.6.z
    execute if score @s Physics.Object.CornerPosGlobal.7.z > @s Physics.Object.BoundingBoxGlobalMax.z run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.z = @s Physics.Object.CornerPosGlobal.7.z

    execute store result score @s Physics.Object.BoundingBoxStepCount.x run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMin.x = @s Physics.Object.BoundingBoxGlobalMax.x
    scoreboard players operation @s Physics.Object.BoundingBoxGlobalMin.x *= #Physics.Constants.-1 Physics
    execute store result score @s Physics.Object.BoundingBoxStepCount.y run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMin.y = @s Physics.Object.BoundingBoxGlobalMax.y
    scoreboard players operation @s Physics.Object.BoundingBoxGlobalMin.y *= #Physics.Constants.-1 Physics
    execute store result score @s Physics.Object.BoundingBoxStepCount.z run scoreboard players operation @s Physics.Object.BoundingBoxGlobalMin.z = @s Physics.Object.BoundingBoxGlobalMax.z
    scoreboard players operation @s Physics.Object.BoundingBoxGlobalMin.z *= #Physics.Constants.-1 Physics

    # Update the StepCount to traverse the bounding box
    # (Important): Note that I made the step count equal to half the bounding box length in the previous step. So in order to ceil() it, instead of dividing by -1000 and multiply by -1, I divide by -500 and multiply by -1
    scoreboard players operation @s Physics.Object.BoundingBoxStepCount.x /= #Physics.Constants.-500 Physics
    scoreboard players operation @s Physics.Object.BoundingBoxStepCount.x *= #Physics.Constants.-1 Physics
    scoreboard players operation @s Physics.Object.BoundingBoxStepCount.y /= #Physics.Constants.-500 Physics
    scoreboard players operation @s Physics.Object.BoundingBoxStepCount.y *= #Physics.Constants.-1 Physics
    scoreboard players operation @s Physics.Object.BoundingBoxStepCount.z /= #Physics.Constants.-500 Physics
    scoreboard players operation @s Physics.Object.BoundingBoxStepCount.z *= #Physics.Constants.-1 Physics

    # Turn the corner coordinates and the bounding box global (Instead of relative to the object center)
    # (Important): If I need the relative bounding box, I'll need to change a few things
    scoreboard players operation @s Physics.Object.CornerPosGlobal.0.x += @s Physics.Object.Pos.x
    scoreboard players operation @s Physics.Object.CornerPosGlobal.0.y += @s Physics.Object.Pos.y
    scoreboard players operation @s Physics.Object.CornerPosGlobal.0.z += @s Physics.Object.Pos.z
    scoreboard players operation @s Physics.Object.CornerPosGlobal.1.x += @s Physics.Object.Pos.x
    scoreboard players operation @s Physics.Object.CornerPosGlobal.1.y += @s Physics.Object.Pos.y
    scoreboard players operation @s Physics.Object.CornerPosGlobal.1.z += @s Physics.Object.Pos.z
    scoreboard players operation @s Physics.Object.CornerPosGlobal.2.x += @s Physics.Object.Pos.x
    scoreboard players operation @s Physics.Object.CornerPosGlobal.2.y += @s Physics.Object.Pos.y
    scoreboard players operation @s Physics.Object.CornerPosGlobal.2.z += @s Physics.Object.Pos.z
    scoreboard players operation @s Physics.Object.CornerPosGlobal.3.x += @s Physics.Object.Pos.x
    scoreboard players operation @s Physics.Object.CornerPosGlobal.3.y += @s Physics.Object.Pos.y
    scoreboard players operation @s Physics.Object.CornerPosGlobal.3.z += @s Physics.Object.Pos.z
    scoreboard players operation @s Physics.Object.CornerPosGlobal.4.x += @s Physics.Object.Pos.x
    scoreboard players operation @s Physics.Object.CornerPosGlobal.4.y += @s Physics.Object.Pos.y
    scoreboard players operation @s Physics.Object.CornerPosGlobal.4.z += @s Physics.Object.Pos.z
    scoreboard players operation @s Physics.Object.CornerPosGlobal.5.x += @s Physics.Object.Pos.x
    scoreboard players operation @s Physics.Object.CornerPosGlobal.5.y += @s Physics.Object.Pos.y
    scoreboard players operation @s Physics.Object.CornerPosGlobal.5.z += @s Physics.Object.Pos.z
    scoreboard players operation @s Physics.Object.CornerPosGlobal.6.x += @s Physics.Object.Pos.x
    scoreboard players operation @s Physics.Object.CornerPosGlobal.6.y += @s Physics.Object.Pos.y
    scoreboard players operation @s Physics.Object.CornerPosGlobal.6.z += @s Physics.Object.Pos.z
    scoreboard players operation @s Physics.Object.CornerPosGlobal.7.x += @s Physics.Object.Pos.x
    scoreboard players operation @s Physics.Object.CornerPosGlobal.7.y += @s Physics.Object.Pos.y
    scoreboard players operation @s Physics.Object.CornerPosGlobal.7.z += @s Physics.Object.Pos.z

    scoreboard players operation @s Physics.Object.BoundingBoxGlobalMin.x += @s Physics.Object.Pos.x
    scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.x += @s Physics.Object.Pos.x
    scoreboard players operation @s Physics.Object.BoundingBoxGlobalMin.y += @s Physics.Object.Pos.y
    scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.y += @s Physics.Object.Pos.y
    scoreboard players operation @s Physics.Object.BoundingBoxGlobalMin.z += @s Physics.Object.Pos.z
    scoreboard players operation @s Physics.Object.BoundingBoxGlobalMax.z += @s Physics.Object.Pos.z

    # Precalculate values for the SAT
        # x, y and z axes of the object (Normalized) => Can be read from the rotation matrix. 1st column is the x axis, and so on

        # Projection of the object onto its own axes
        # (Important): I use "execute store result ..." earlier to copy the axis values into the temp scores when it's getting calculated (= when the rotation matrix is set), so I don't need multiple "scoreboard players operation ... = ..." calls
            # x axis
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.ObjectAxis.x Physics *= @s Physics.Object.CornerPosRelative.0.x

                scoreboard players operation #Physics.Maths.Value43 Physics *= @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Projection.ObjectCorner0.ObjectAxis.x Physics += #Physics.Maths.Value43 Physics

                scoreboard players operation #Physics.Maths.Value44 Physics *= @s Physics.Object.CornerPosRelative.0.z
                execute store result score #Physics.Projection.ObjectCorner7.ObjectAxis.x Physics store result score #Physics.Projection.Object.ObjectAxis.x.Min Physics store result score #Physics.Projection.Object.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.ObjectAxis.x Physics += #Physics.Maths.Value44 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.ObjectAxis.x Physics *= @s Physics.Object.CornerPosRelative.1.x

                scoreboard players operation #Physics.Maths.Value45 Physics *= @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Projection.ObjectCorner1.ObjectAxis.x Physics += #Physics.Maths.Value45 Physics

                scoreboard players operation #Physics.Maths.Value46 Physics *= @s Physics.Object.CornerPosRelative.1.z
                execute store result score #Physics.Projection.ObjectCorner6.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.ObjectAxis.x Physics += #Physics.Maths.Value46 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.ObjectAxis.x Physics *= @s Physics.Object.CornerPosRelative.2.x

                scoreboard players operation #Physics.Maths.Value47 Physics *= @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Projection.ObjectCorner2.ObjectAxis.x Physics += #Physics.Maths.Value47 Physics

                scoreboard players operation #Physics.Maths.Value48 Physics *= @s Physics.Object.CornerPosRelative.2.z
                execute store result score #Physics.Projection.ObjectCorner5.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.ObjectAxis.x Physics += #Physics.Maths.Value48 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.ObjectCorner3.ObjectAxis.x Physics *= @s Physics.Object.CornerPosRelative.3.x

                scoreboard players operation #Physics.Maths.Value49 Physics *= @s Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Projection.ObjectCorner3.ObjectAxis.x Physics += #Physics.Maths.Value49 Physics

                scoreboard players operation #Physics.Maths.Value50 Physics *= @s Physics.Object.CornerPosRelative.3.z
                execute store result score #Physics.Projection.ObjectCorner4.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.ObjectAxis.x Physics += #Physics.Maths.Value50 Physics

                # Corner 4 (Mirrored version of 3)
                scoreboard players operation #Physics.Projection.ObjectCorner4.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.ObjectCorner5.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner6.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 7 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner7.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Find min and max (Relative to object center)
                execute if score #Physics.Projection.ObjectCorner1.ObjectAxis.x Physics > #Physics.Projection.Object.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner1.ObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner2.ObjectAxis.x Physics > #Physics.Projection.Object.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner2.ObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner3.ObjectAxis.x Physics > #Physics.Projection.Object.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner3.ObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner4.ObjectAxis.x Physics > #Physics.Projection.Object.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner4.ObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner5.ObjectAxis.x Physics > #Physics.Projection.Object.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner5.ObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner6.ObjectAxis.x Physics > #Physics.Projection.Object.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner6.ObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner7.ObjectAxis.x Physics > #Physics.Projection.Object.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner7.ObjectAxis.x Physics
                execute store result score #Physics.Projection.Object.ObjectAxis.x.Min Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.x.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.ObjectAxis.x.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the min and max global by projecting the center point onto the same axis and adding it to the min and max
                # (Important): I divide the projection by 1,000x to ensure consistent scaling, because multiplying a number that's scaled by 1,000x with another number that's scaled the same will result in a scaling of 1,000,000x.
                scoreboard players operation #Physics.Projection.ObjectCenter.ObjectAxis.x Physics *= @s Physics.Object.Pos.x

                scoreboard players operation #Physics.Maths.Value51 Physics *= @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Projection.ObjectCenter.ObjectAxis.x Physics += #Physics.Maths.Value51 Physics

                scoreboard players operation #Physics.Maths.Value52 Physics *= @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Projection.ObjectCenter.ObjectAxis.x Physics += #Physics.Maths.Value52 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.ObjectAxis.x Physics /= #Physics.Constants.1000 Physics

                execute store result score @s Physics.Object.ProjectionOwnAxis.x.Min run scoreboard players operation #Physics.Projection.Object.ObjectAxis.x.Min Physics += #Physics.Projection.ObjectCenter.ObjectAxis.x Physics
                execute store result score @s Physics.Object.ProjectionOwnAxis.x.Max run scoreboard players operation #Physics.Projection.Object.ObjectAxis.x.Max Physics += #Physics.Projection.ObjectCenter.ObjectAxis.x Physics

            # y axis
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.ObjectAxis.y Physics *= @s Physics.Object.CornerPosRelative.0.x

                scoreboard players operation #Physics.Maths.Value53 Physics *= @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Projection.ObjectCorner0.ObjectAxis.y Physics += #Physics.Maths.Value53 Physics

                scoreboard players operation #Physics.Maths.Value54 Physics *= @s Physics.Object.CornerPosRelative.0.z
                execute store result score #Physics.Projection.ObjectCorner7.ObjectAxis.y Physics store result score #Physics.Projection.Object.ObjectAxis.y.Min Physics store result score #Physics.Projection.Object.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.ObjectAxis.y Physics += #Physics.Maths.Value54 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.ObjectAxis.y Physics *= @s Physics.Object.CornerPosRelative.1.x

                scoreboard players operation #Physics.Maths.Value55 Physics *= @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Projection.ObjectCorner1.ObjectAxis.y Physics += #Physics.Maths.Value55 Physics

                scoreboard players operation #Physics.Maths.Value56 Physics *= @s Physics.Object.CornerPosRelative.1.z
                execute store result score #Physics.Projection.ObjectCorner6.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.ObjectAxis.y Physics += #Physics.Maths.Value56 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.ObjectAxis.y Physics *= @s Physics.Object.CornerPosRelative.2.x

                scoreboard players operation #Physics.Maths.Value57 Physics *= @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Projection.ObjectCorner2.ObjectAxis.y Physics += #Physics.Maths.Value57 Physics

                scoreboard players operation #Physics.Maths.Value58 Physics *= @s Physics.Object.CornerPosRelative.2.z
                execute store result score #Physics.Projection.ObjectCorner5.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.ObjectAxis.y Physics += #Physics.Maths.Value58 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.ObjectCorner3.ObjectAxis.y Physics *= @s Physics.Object.CornerPosRelative.3.x

                scoreboard players operation #Physics.Maths.Value59 Physics *= @s Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Projection.ObjectCorner3.ObjectAxis.y Physics += #Physics.Maths.Value59 Physics

                scoreboard players operation #Physics.Maths.Value60 Physics *= @s Physics.Object.CornerPosRelative.3.z
                execute store result score #Physics.Projection.ObjectCorner4.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.ObjectAxis.y Physics += #Physics.Maths.Value60 Physics

                # Corner 4 (Mirrored version of 3)
                scoreboard players operation #Physics.Projection.ObjectCorner4.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.ObjectCorner5.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner6.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 7 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner7.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Find min and max (Relative to object center)
                execute if score #Physics.Projection.ObjectCorner1.ObjectAxis.y Physics > #Physics.Projection.Object.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner1.ObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner2.ObjectAxis.y Physics > #Physics.Projection.Object.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner2.ObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner3.ObjectAxis.y Physics > #Physics.Projection.Object.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner3.ObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner4.ObjectAxis.y Physics > #Physics.Projection.Object.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner4.ObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner5.ObjectAxis.y Physics > #Physics.Projection.Object.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner5.ObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner6.ObjectAxis.y Physics > #Physics.Projection.Object.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner6.ObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner7.ObjectAxis.y Physics > #Physics.Projection.Object.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner7.ObjectAxis.y Physics
                execute store result score #Physics.Projection.Object.ObjectAxis.y.Min Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.y.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.ObjectAxis.y.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the min and max global by projecting the center point onto the same axis and adding it to the min and max
                # (Important): I divide the projection by 1,000x to ensure consistent scaling, because multiplying a number that's scaled by 1,000x with another number that's scaled the same will result in a scaling of 1,000,000x.
                scoreboard players operation #Physics.Projection.ObjectCenter.ObjectAxis.y Physics *= @s Physics.Object.Pos.x

                scoreboard players operation #Physics.Maths.Value61 Physics *= @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Projection.ObjectCenter.ObjectAxis.y Physics += #Physics.Maths.Value61 Physics

                scoreboard players operation #Physics.Maths.Value62 Physics *= @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Projection.ObjectCenter.ObjectAxis.y Physics += #Physics.Maths.Value62 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.ObjectAxis.y Physics /= #Physics.Constants.1000 Physics

                execute store result score @s Physics.Object.ProjectionOwnAxis.y.Min run scoreboard players operation #Physics.Projection.Object.ObjectAxis.y.Min Physics += #Physics.Projection.ObjectCenter.ObjectAxis.y Physics
                execute store result score @s Physics.Object.ProjectionOwnAxis.y.Max run scoreboard players operation #Physics.Projection.Object.ObjectAxis.y.Max Physics += #Physics.Projection.ObjectCenter.ObjectAxis.y Physics

            # z axis
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.ObjectAxis.z Physics *= @s Physics.Object.CornerPosRelative.0.x

                scoreboard players operation #Physics.Maths.Value63 Physics *= @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Projection.ObjectCorner0.ObjectAxis.z Physics += #Physics.Maths.Value63 Physics

                scoreboard players operation #Physics.Maths.Value64 Physics *= @s Physics.Object.CornerPosRelative.0.z
                execute store result score #Physics.Projection.ObjectCorner7.ObjectAxis.z Physics store result score #Physics.Projection.Object.ObjectAxis.z.Min Physics store result score #Physics.Projection.Object.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.ObjectAxis.z Physics += #Physics.Maths.Value64 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.ObjectAxis.z Physics *= @s Physics.Object.CornerPosRelative.1.x

                scoreboard players operation #Physics.Maths.Value65 Physics *= @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Projection.ObjectCorner1.ObjectAxis.z Physics += #Physics.Maths.Value65 Physics

                scoreboard players operation #Physics.Maths.Value66 Physics *= @s Physics.Object.CornerPosRelative.1.z
                execute store result score #Physics.Projection.ObjectCorner6.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.ObjectAxis.z Physics += #Physics.Maths.Value66 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.ObjectAxis.z Physics *= @s Physics.Object.CornerPosRelative.2.x

                scoreboard players operation #Physics.Maths.Value67 Physics *= @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Projection.ObjectCorner2.ObjectAxis.z Physics += #Physics.Maths.Value67 Physics

                scoreboard players operation #Physics.Maths.Value68 Physics *= @s Physics.Object.CornerPosRelative.2.z
                execute store result score #Physics.Projection.ObjectCorner5.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.ObjectAxis.z Physics += #Physics.Maths.Value68 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.ObjectCorner3.ObjectAxis.z Physics *= @s Physics.Object.CornerPosRelative.3.x

                scoreboard players operation #Physics.Maths.Value69 Physics *= @s Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Projection.ObjectCorner3.ObjectAxis.z Physics += #Physics.Maths.Value69 Physics

                scoreboard players operation #Physics.Maths.Value70 Physics *= @s Physics.Object.CornerPosRelative.3.z
                execute store result score #Physics.Projection.ObjectCorner4.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.ObjectAxis.z Physics += #Physics.Maths.Value70 Physics

                # Corner 4 (Mirrored version of 3)
                scoreboard players operation #Physics.Projection.ObjectCorner4.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.ObjectCorner5.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner6.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 7 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner7.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Find min and max (Relative to object center)
                execute if score #Physics.Projection.ObjectCorner1.ObjectAxis.z Physics > #Physics.Projection.Object.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner1.ObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner2.ObjectAxis.z Physics > #Physics.Projection.Object.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner2.ObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner3.ObjectAxis.z Physics > #Physics.Projection.Object.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner3.ObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner4.ObjectAxis.z Physics > #Physics.Projection.Object.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner4.ObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner5.ObjectAxis.z Physics > #Physics.Projection.Object.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner5.ObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner6.ObjectAxis.z Physics > #Physics.Projection.Object.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner6.ObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner7.ObjectAxis.z Physics > #Physics.Projection.Object.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner7.ObjectAxis.z Physics
                execute store result score #Physics.Projection.Object.ObjectAxis.z.Min Physics run scoreboard players operation #Physics.Projection.Object.ObjectAxis.z.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.ObjectAxis.z.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the min and max global by projecting the center point onto the same axis and adding it to the min and max
                # (Important): I divide the projection by 1,000x to ensure consistent scaling, because multiplying a number that's scaled by 1,000x with another number that's scaled the same will result in a scaling of 1,000,000x.
                scoreboard players operation #Physics.Projection.ObjectCenter.ObjectAxis.z Physics *= @s Physics.Object.Pos.x

                scoreboard players operation #Physics.Maths.Value71 Physics *= @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Projection.ObjectCenter.ObjectAxis.z Physics += #Physics.Maths.Value71 Physics

                scoreboard players operation #Physics.Maths.Value72 Physics *= @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Projection.ObjectCenter.ObjectAxis.z Physics += #Physics.Maths.Value72 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.ObjectAxis.z Physics /= #Physics.Constants.1000 Physics

                execute store result score @s Physics.Object.ProjectionOwnAxis.z.Min run scoreboard players operation #Physics.Projection.Object.ObjectAxis.z.Min Physics += #Physics.Projection.ObjectCenter.ObjectAxis.z Physics
                execute store result score @s Physics.Object.ProjectionOwnAxis.z.Max run scoreboard players operation #Physics.Projection.Object.ObjectAxis.z.Max Physics += #Physics.Projection.ObjectCenter.ObjectAxis.z Physics

# Clear accumulators
scoreboard players set @s Physics.Object.AccumulatedForce.x 0
scoreboard players set @s Physics.Object.AccumulatedForce.y 0
scoreboard players set @s Physics.Object.AccumulatedForce.z 0

scoreboard players set @s Physics.Object.AccumulatedTorque.x 0
scoreboard players set @s Physics.Object.AccumulatedTorque.y 0
scoreboard players set @s Physics.Object.AccumulatedTorque.z 0

# Update NBT if it changed
data modify entity @s {} merge from storage physics:temp data.Integration
