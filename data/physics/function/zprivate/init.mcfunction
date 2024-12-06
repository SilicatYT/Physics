# Init
scoreboard players set #Physics.Init Physics 1
tellraw @a ["",{"text":"Physics >> ","color":"#99EAD6"},"Installed Physics (v0.1.0)\n"]

scoreboard objectives add Physics.Value dummy

# Add object attributes
scoreboard objectives add Physics.Object.Pos.x dummy
scoreboard objectives add Physics.Object.Pos.y dummy
scoreboard objectives add Physics.Object.Pos.z dummy
scoreboard objectives add Physics.Object.Velocity.x dummy
scoreboard objectives add Physics.Object.Velocity.y dummy
scoreboard objectives add Physics.Object.Velocity.z dummy
scoreboard objectives add Physics.Object.InverseMass dummy
scoreboard objectives add Physics.Object.Gravity dummy
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

scoreboard objectives add Physics.Object.Dimension.x dummy
scoreboard objectives add Physics.Object.Dimension.y dummy
scoreboard objectives add Physics.Object.Dimension.z dummy

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

# Set global variables
scoreboard players set #Physics.Global.LinearDamping Physics.Value 95
scoreboard players set #Physics.Global.AngularDamping Physics.Value 95

# Set value constants (You can't multiply or divide by numbers without defining them first using scoreboards)
scoreboard players set #Physics.Constants.2 Physics.Value 2
scoreboard players set #Physics.Constants.10 Physics.Value 10
scoreboard players set #Physics.Constants.12 Physics.Value 12
scoreboard players set #Physics.Constants.100 Physics.Value 100
scoreboard players set #Physics.Constants.141 Physics.Value 141
scoreboard players set #Physics.Constants.500 Physics.Value 500
scoreboard players set #Physics.Constants.1000 Physics.Value 1000
scoreboard players set #Physics.Constants.2000 Physics.Value 2000
scoreboard players set #Physics.Constants.7775 Physics.Value 7775
scoreboard players set #Physics.Constants.10000 Physics.Value 10000
scoreboard players set #Physics.Constants.100000 Physics.Value 100000

# Setup starting values for data storages
data modify storage physics:temp data.Integration set value {Pos:[0d,0d,0d],start_interpolation:0,transformation:{left_rotation:[0f,0f,0f,0f]}}
data modify storage physics:temp data.Integration.Pos set value [0d,0d,0d]
data modify storage physics:temp data.IntersectionPosGlobal set value [0d,0d,0d]
data modify storage physics:maths processing.Distance set value [0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,0f,1f]
