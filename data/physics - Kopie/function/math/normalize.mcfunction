# Create a unit vector
# Note: (Input needs to be scaled by 1,000)

execute store result storage physics:zprivate temp.Pos[0] double 0.001 run scoreboard players get #normalize.x val
execute store result storage physics:zprivate temp.Pos[1] double 0.001 run scoreboard players get #normalize.y val
execute store result storage physics:zprivate temp.Pos[2] double 0.001 run scoreboard players get #normalize.z val

data modify entity 0-0-0-0-0 Pos set from storage physics:zprivate temp.Pos
execute positioned as 0-0-0-0-0 facing 0.0 0.0 0.0 positioned 0.0 0.0 0.0 run tp 0-0-0-0-0 ^ ^ ^-1

data modify storage physics:util normalize.out set from entity 0-0-0-0-0 Pos
