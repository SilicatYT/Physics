# By SuperSword
# Note: (METHOD DOESNT GIVE GREAT COMMA ACCURACY. 500,500,500 makes it so the last 3 digits are unused entirely. 5,5,5 makes the last digit unused)
# Note: Very fast
# Note: Result scaled up by 1,000 -> Depending on where I need to use it, it might be too little or too much accuracy

# How to use: Set #get_magnitude.X val, #Distance.Y val and #get_magnitude.Z val. Run this function and the result is in #get_magnitude.out val
execute if score #get_magnitude.y val matches 0 run scoreboard players operation #get_magnitude.y val >< #get_magnitude.x val
execute if score #get_magnitude.y val matches 0 run scoreboard players operation #get_magnitude.y val >< #get_magnitude.z val

# TP
execute store result storage physics:zprivate temp.Pos[0] double 1 run scoreboard players get #get_magnitude.x val
execute store result storage physics:zprivate temp.Pos[1] double 1 run scoreboard players get #get_magnitude.y val
execute store result storage physics:zprivate temp.Pos[2] double 1 run scoreboard players get #get_magnitude.z val
data modify entity 0-0-0-0-0 Pos set from storage physics:zprivate temp.Pos
rotate 0-0-0-0-0 facing 0.0 0.0 0.0
execute store result storage physics:zprivate temp.t int 1 run data get entity 0-0-0-0-0 Rotation[1] 100

# Trig
function physics:zprivate/math/get_magnitude/sine with storage physics:zprivate temp
scoreboard players operation #get_magnitude.out val *= #get_magnitude.y val
