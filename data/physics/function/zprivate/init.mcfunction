# Init
scoreboard players set #Physics.Init Physics 1
tellraw @a ["",{"text":"Physics >> ","color":"#99EAD6"},"Installed Physics (v0.1.0)\n"]

# Add object attributes
scoreboard objectives add Physics.Object.ID dummy
scoreboard objectives add Physics.Object.Pos.x dummy
scoreboard objectives add Physics.Object.Pos.y dummy
scoreboard objectives add Physics.Object.Pos.z dummy
scoreboard objectives add Physics.Object.Velocity.x dummy
scoreboard objectives add Physics.Object.Velocity.y dummy
scoreboard objectives add Physics.Object.Velocity.z dummy
scoreboard objectives add Physics.Object.InverseMass dummy
scoreboard objectives add Physics.Object.Gravity dummy
scoreboard objectives add Physics.Object.Dimension.x dummy
scoreboard objectives add Physics.Object.Dimension.y dummy
scoreboard objectives add Physics.Object.Dimension.z dummy
scoreboard objectives add Physics.Object.AccumulatedForce.x dummy
scoreboard objectives add Physics.Object.AccumulatedForce.y dummy
scoreboard objectives add Physics.Object.AccumulatedForce.z dummy
scoreboard objectives add Physics.Object.AccumulatedTorque.x dummy
scoreboard objectives add Physics.Object.AccumulatedTorque.y dummy
scoreboard objectives add Physics.Object.AccumulatedTorque.z dummy
scoreboard objectives add Physics.Object.Orientation.x dummy
scoreboard objectives add Physics.Object.Orientation.y dummy
scoreboard objectives add Physics.Object.Orientation.z dummy
scoreboard objectives add Physics.Object.Orientation.a dummy
scoreboard objectives add Physics.Object.AngularVelocity.x dummy
scoreboard objectives add Physics.Object.AngularVelocity.y dummy
scoreboard objectives add Physics.Object.AngularVelocity.z dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorLocal.0 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorLocal.4 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorLocal.8 dummy

# Add derived object attributes (Calculated from object attributes, but stored separately to prevent repeated calculations)
scoreboard objectives add Physics.Object.RotationMatrix.0 dummy
scoreboard objectives add Physics.Object.RotationMatrix.1 dummy
scoreboard objectives add Physics.Object.RotationMatrix.2 dummy
scoreboard objectives add Physics.Object.RotationMatrix.3 dummy
scoreboard objectives add Physics.Object.RotationMatrix.4 dummy
scoreboard objectives add Physics.Object.RotationMatrix.5 dummy
scoreboard objectives add Physics.Object.RotationMatrix.6 dummy
scoreboard objectives add Physics.Object.RotationMatrix.7 dummy
scoreboard objectives add Physics.Object.RotationMatrix.8 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.0 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.1 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.2 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.3 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.4 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.5 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.6 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.7 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.8 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.0 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.1 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.2 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.3 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.4 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.5 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.6 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.7 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.8 dummy
scoreboard objectives add Physics.Object.BoundingBoxLocalMax.x dummy
scoreboard objectives add Physics.Object.BoundingBoxLocalMin.x dummy
scoreboard objectives add Physics.Object.BoundingBoxLocalMax.y dummy
scoreboard objectives add Physics.Object.BoundingBoxLocalMin.y dummy
scoreboard objectives add Physics.Object.BoundingBoxLocalMax.z dummy
scoreboard objectives add Physics.Object.BoundingBoxLocalMin.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.0.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.0.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.0.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.1.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.1.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.1.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.2.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.2.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.2.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.3.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.3.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.3.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.4.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.4.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.4.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.5.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.5.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.5.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.6.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.6.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.6.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.7.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.7.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.7.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.0.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.0.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.0.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.1.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.1.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.1.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.2.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.2.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.2.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.3.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.3.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.3.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.4.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.4.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.4.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.5.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.5.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.5.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.6.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.6.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.6.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.7.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.7.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.7.z dummy
scoreboard objectives add Physics.Object.BoundingBoxGlobalMin.x dummy
scoreboard objectives add Physics.Object.BoundingBoxGlobalMax.x dummy
scoreboard objectives add Physics.Object.BoundingBoxGlobalMin.y dummy
scoreboard objectives add Physics.Object.BoundingBoxGlobalMax.y dummy
scoreboard objectives add Physics.Object.BoundingBoxGlobalMin.z dummy
scoreboard objectives add Physics.Object.BoundingBoxGlobalMax.z dummy
scoreboard objectives add Physics.Object.BoundingBoxStepCount.x dummy
scoreboard objectives add Physics.Object.BoundingBoxStepCount.y dummy
scoreboard objectives add Physics.Object.BoundingBoxStepCount.z dummy
scoreboard objectives add Physics.Object.Axis.x.x dummy
scoreboard objectives add Physics.Object.Axis.x.y dummy
scoreboard objectives add Physics.Object.Axis.x.z dummy
scoreboard objectives add Physics.Object.Axis.y.x dummy
scoreboard objectives add Physics.Object.Axis.y.y dummy
scoreboard objectives add Physics.Object.Axis.y.z dummy
scoreboard objectives add Physics.Object.Axis.z.x dummy
scoreboard objectives add Physics.Object.Axis.z.y dummy
scoreboard objectives add Physics.Object.Axis.z.z dummy
scoreboard objectives add Physics.Object.ProjectionOwnAxis.x.Min dummy
scoreboard objectives add Physics.Object.ProjectionOwnAxis.x.Max dummy
scoreboard objectives add Physics.Object.ProjectionOwnAxis.y.Min dummy
scoreboard objectives add Physics.Object.ProjectionOwnAxis.y.Max dummy
scoreboard objectives add Physics.Object.ProjectionOwnAxis.z.Min dummy
scoreboard objectives add Physics.Object.ProjectionOwnAxis.z.Max dummy

# Set global variables
scoreboard players set #Physics.Global.DefaultGravity Physics 490
scoreboard players set #Physics.Global.LinearDamping Physics 98
scoreboard players set #Physics.Global.AngularDamping Physics 98
scoreboard players set #Physics.Global.PlayerAttackForceMagnitude Physics 300

# Set value constants
scoreboard players set #Physics.Constants.-1000 Physics -1000
scoreboard players set #Physics.Constants.-500 Physics -500
scoreboard players set #Physics.Constants.-2 Physics -2
scoreboard players set #Physics.Constants.-1 Physics -1
scoreboard players set #Physics.Constants.2 Physics 2
scoreboard players set #Physics.Constants.10 Physics 10
scoreboard players set #Physics.Constants.12 Physics 12
scoreboard players set #Physics.Constants.20 Physics 20
scoreboard players set #Physics.Constants.100 Physics 100
scoreboard players set #Physics.Constants.141 Physics 141
scoreboard players set #Physics.Constants.500 Physics 500
scoreboard players set #Physics.Constants.833 Physics 833
scoreboard players set #Physics.Constants.1000 Physics 1000
scoreboard players set #Physics.Constants.2000 Physics 2000
scoreboard players set #Physics.Constants.7775 Physics 7775
scoreboard players set #Physics.Constants.10000 Physics 10000
scoreboard players set #Physics.Constants.100000 Physics 100000

# Setup starting values for data storages
data modify storage physics:temp data.Integration set value {Pos:[0d,0d,0d],start_interpolation:0,transformation:{left_rotation:[0f,0f,0f,0f]}}
data modify storage physics:temp data.Integration.Pos set value [0d,0d,0d]
data modify storage physics:temp data.IntersectionPosGlobal set value [0d,0d,0d]
data modify storage physics:maths processing.Distance set value [0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,1f]
data modify storage physics:temp data.NewContact.ContactNormal set value [I;0,0,0]
data modify storage physics:temp data.NewContact.ContactPoint set value [I;0,0,0]

# Set gamerules
gamerule maxCommandChainLength 2147483647
