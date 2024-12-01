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
scoreboard objectives add Physics.Object.AngularAcceleration.x dummy
scoreboard objectives add Physics.Object.AngularAcceleration.y dummy
scoreboard objectives add Physics.Object.AngularAcceleration.z dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorLocal.0 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorLocal.4 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorLocal.8 dummy

scoreboard objectives add Physics.Object.Dimension.x dummy
scoreboard objectives add Physics.Object.Dimension.y dummy
scoreboard objectives add Physics.Object.Dimension.z dummy

# Add derived object attributes (Calculated from object attributes, but stored separately to prevent repeated calculations)
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
#LinearDamping (Hardcoded, not using a score)
#AngularDamping (Hardcoded, not using a score)
scoreboard players set #Physics.Global.Default.Gravity Physics.Value 4905000

# Set value constants (You can't multiply or divide by numbers without defining them first using scoreboards)
scoreboard players set #Physics.Constants.12 Physics.Value 12
scoreboard players set #Physics.Constants.100 Physics.Value 100
