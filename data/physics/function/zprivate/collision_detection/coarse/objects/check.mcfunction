# Rough collision check
    # Get the squared distance by getting the position difference on each axis, then adding them together and then making the result positive if necessary
    scoreboard players operation #Physics.Maths.Temp.SquaredDistance Physics.Value = @s Physics.Object.Pos.x
    scoreboard players operation #Physics.Maths.Temp.SquaredDistance Physics.Value -= #Physics.OtherObject Physics.Object.Pos.x
    scoreboard players operation #Physics.Maths.Temp.SquaredDistance Physics.Value *= #Physics.Maths.Temp.SquaredDistance Physics.Value
    #scoreboard players operation #Physics.Maths.Temp.SquaredDistance Physics.Value /= #Physics.Constants.1000 Physics.Value

    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value = @s Physics.Object.Pos.y
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value -= #Physics.OtherObject Physics.Object.Pos.y
    scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value *= #Physics.Maths.Temp.Value1 Physics.Value
    #scoreboard players operation #Physics.Maths.Temp.Value1 Physics.Value /= #Physics.Constants.1000 Physics.Value

    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value = @s Physics.Object.Pos.z
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value -= #Physics.OtherObject Physics.Object.Pos.z
    scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value *= #Physics.Maths.Temp.Value2 Physics.Value
    #scoreboard players operation #Physics.Maths.Temp.Value2 Physics.Value /= #Physics.Constants.1000 Physics.Value

    scoreboard players operation #Physics.Maths.Temp.SquaredDistance Physics.Value += #Physics.Maths.Temp.Value1 Physics.Value
    scoreboard players operation #Physics.Maths.Temp.SquaredDistance Physics.Value += #Physics.Maths.Temp.Value2 Physics.Value

    execute if score #Physics.Maths.Temp.SquaredDistance Physics.Value matches ..-1 run scoreboard players operation #Physics.Maths.Temp.SquaredDistance Physics.Value *= #Physics.Constants.-1 Physics.Value

    # Check if the squared distance is less than (HitboxRadiusA + HitboxRadiusB)^2 (Negative: They intersect)
    scoreboard players operation #Physics.Maths.Temp.SquaredRadius Physics.Value = @s Physics.Object.HitboxRadius
    scoreboard players operation #Physics.Maths.Temp.SquaredRadius Physics.Value += #Physics.OtherObject Physics.Object.HitboxRadius
    scoreboard players operation #Physics.Maths.Temp.SquaredRadius Physics.Value *= #Physics.Maths.Temp.SquaredRadius Physics.Value

    execute if score #Physics.Maths.Temp.SquaredDistance Physics.Value < #Physics.Maths.Temp.SquaredRadius Physics.Value run particle minecraft:flame ~ ~ ~ 0.3 0.3 0.3 0 1

