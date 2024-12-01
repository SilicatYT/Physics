# Check if it's installed
scoreboard objectives remove Physics.Uninstall
execute if score #Physics.Init Physics matches 1 run scoreboard players set #Physics.Init Physics.Uninstall 1
execute unless score #Physics.Init Physics.Uninstall matches 1 run tellraw @a ["",{"text":"Physics >> ","color":"#99EAD6"},{"text":"⚠ Could not remove Physics.\nIs it installed?","color":"red"}]
execute unless score #Physics.Init Physics.Uninstall matches 1 run return run scoreboard objectives remove Physics.Uninstall
scoreboard objectives remove Physics.Uninstall

# Tellraw
tellraw @s ["",{"text":"Physics >> ","color":"#99EAD6"},"Uninstalled Physics (v0.1.0)"]

# Remove scoreboard objectives
scoreboard objectives remove Physics
scoreboard objectives remove Physics.Value

scoreboard objectives remove Physics.Object.Pos.x
scoreboard objectives remove Physics.Object.Pos.y
scoreboard objectives remove Physics.Object.Pos.z
scoreboard objectives remove Physics.Object.Velocity.x
scoreboard objectives remove Physics.Object.Velocity.y
scoreboard objectives remove Physics.Object.Velocity.z
scoreboard objectives remove Physics.Object.InverseMass
scoreboard objectives remove Physics.Object.Gravity
scoreboard objectives remove Physics.Object.AccumulatedForce.x
scoreboard objectives remove Physics.Object.AccumulatedForce.y
scoreboard objectives remove Physics.Object.AccumulatedForce.z
scoreboard objectives remove Physics.Object.AccumulatedTorque.x
scoreboard objectives remove Physics.Object.AccumulatedTorque.y
scoreboard objectives remove Physics.Object.AccumulatedTorque.z
scoreboard objectives remove Physics.Object.Orientation.x
scoreboard objectives remove Physics.Object.Orientation.y
scoreboard objectives remove Physics.Object.Orientation.z
scoreboard objectives remove Physics.Object.Orientation.a
scoreboard objectives remove Physics.Object.AngularVelocity.x
scoreboard objectives remove Physics.Object.AngularVelocity.y
scoreboard objectives remove Physics.Object.AngularVelocity.z
scoreboard objectives remove Physics.Object.AngularAcceleration.x
scoreboard objectives remove Physics.Object.AngularAcceleration.y
scoreboard objectives remove Physics.Object.AngularAcceleration.z
scoreboard objectives remove Physics.Object.InverseInertiaTensorLocal.0
scoreboard objectives remove Physics.Object.InverseInertiaTensorLocal.4
scoreboard objectives remove Physics.Object.InverseInertiaTensorLocal.8

scoreboard objectives remove Physics.Object.Dimension.x
scoreboard objectives remove Physics.Object.Dimension.y
scoreboard objectives remove Physics.Object.Dimension.z

scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.0
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.1
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.2
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.3
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.4
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.5
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.6
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.7
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.8

# Remove data storages
data remove storage physics:object data
