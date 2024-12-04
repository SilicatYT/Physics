# Get the square root of a number (Method by Triton365)
# INPUT: scoreboard players set #Physics.Maths.SquareRoot.Input Physics.Value <x>

execute store result score #Physics.Maths.Temp.SquareRoot.Value2 Physics.Value run scoreboard players operation #Physics.Maths.Temp.SquareRoot.Value1 Physics.Value = #Physics.Maths.SquareRoot.Input Physics.Value
execute if score #Physics.Maths.SquareRoot.Input Physics.Value matches 0..19310 run function physics:zprivate/maths/get_square_root/0
execute if score #Physics.Maths.SquareRoot.Input Physics.Value matches 19311..1705544 run function physics:zprivate/maths/get_square_root/1
execute if score #Physics.Maths.SquareRoot.Input Physics.Value matches 1705545..39400514 run function physics:zprivate/maths/get_square_root/2
execute if score #Physics.Maths.SquareRoot.Input Physics.Value matches 39400515..455779650 run function physics:zprivate/maths/get_square_root/3
execute if score #Physics.Maths.SquareRoot.Input Physics.Value matches 455779651..2147483647 run function physics:zprivate/maths/get_square_root/4

scoreboard players operation #Physics.Maths.Temp.SquareRoot.Value2 Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
scoreboard players operation #Physics.Maths.SquareRoot.Output Physics.Value += #Physics.Maths.Temp.SquareRoot.Value2 Physics.Value
scoreboard players operation #Physics.Maths.SquareRoot.Output Physics.Value /= #Physics.Constants.2 Physics.Value
scoreboard players operation #Physics.Maths.SquareRoot.Input Physics.Value /= #Physics.Maths.SquareRoot.Output Physics.Value
execute if score #Physics.Maths.SquareRoot.Output Physics.Value > #Physics.Maths.SquareRoot.Input Physics.Value run scoreboard players remove #Physics.Maths.SquareRoot.Output Physics.Value 1

# OUTPUT: scoreboard players get #Physics.Maths.SquareRoot.Output Physics.Value
