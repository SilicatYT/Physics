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
    # Inverse global inertia tensor

# Clear accumulators
scoreboard players set @s Physics.Object.AccumulatedForce.x 0
scoreboard players set @s Physics.Object.AccumulatedForce.y 0
scoreboard players set @s Physics.Object.AccumulatedForce.z 0

scoreboard players set @s Physics.Object.AccumulatedTorque.x 0
scoreboard players set @s Physics.Object.AccumulatedTorque.y 0
scoreboard players set @s Physics.Object.AccumulatedTorque.z 0

# Update NBT
data modify entity @s {} merge from storage physics:temp data.Integration
